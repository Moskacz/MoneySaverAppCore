//
//  TransactionRepository.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 15.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData
import MMFoundation

internal class CoreDataTransactionsRepository: TransactionsRepository {
    
    private let context: NSManagedObjectContext
    private let logger: Logger
    private let notificationCenter: TransactionNotificationCenter
    private let calendar: CalendarProtocol
    
    internal init(context: NSManagedObjectContext,
                  logger: Logger,
                  notificationCenter: TransactionNotificationCenter,
                  calendar: CalendarProtocol) {
        self.context = context
        self.logger = logger
        self.notificationCenter = notificationCenter
        self.calendar = calendar
    }
    
    func transactionsResultsController(transactionsMonthOfEra: Int) -> ResultsController<TransactionProtocol> {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: TransactionManagedObject.KeyPath.timeInterval.string, ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return TransactionResultsController(frc: frc)
    }
    
    internal var allTransactionsResultController: ResultsController<TransactionProtocol> {
        let frc = NSFetchedResultsController(fetchRequest: resultsControllerFetchRequest,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: TransactionManagedObject.KeyPath.dayOfEra.string,
                                             cacheName: nil)
        return TransactionResultsController(frc: frc)
    }
    
    internal func transactionsResultsController(dateRange: DateRange) -> ResultsController<TransactionProtocol> {
        let fetchRequest = resultsControllerFetchRequest
        fetchRequest.predicate = predicate(for: dateRange)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: TransactionManagedObject.KeyPath.dayOfEra.string,
                                             cacheName: nil)
        return TransactionResultsController(frc: frc)
    }
    
    private var resultsControllerFetchRequest: NSFetchRequest<TransactionManagedObject> {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        
        request.sortDescriptors = [NSSortDescriptor(key: TransactionManagedObject.KeyPath.dayOfEra.string, ascending: false),
                                   NSSortDescriptor(key: TransactionManagedObject.KeyPath.timeInterval.string, ascending: false)]
        return request
    }
    
    private func predicate(for dateRange: DateRange) -> NSPredicate {
        switch dateRange {
        case .allTime: return NSPredicate(value: true)
        case .thisMonth:
            let monthOfEra = calendar.nowCalendarDate.monthOfEra
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.monthOfEra.string) == \(monthOfEra)")
        case .thisWeek:
            let weekOfEra = calendar.nowCalendarDate.weekOfEra
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.weekOfEra.string) == \(weekOfEra)")
        case .thisYear:
            let year = calendar.nowCalendarDate.year
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.year.string) == \(year)")
        case .today:
            let dayOfEra = calendar.nowCalendarDate.dayOfEra
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.dayOfEra.string) == \(dayOfEra)")
        }
    }
    
    internal func addTransaction(data: TransactionData, category: TransactionCategoryProtocol) {
        guard let coreDataCategory = category as? TransactionCategoryManagedObject else { return }
        
        context.performAndWait {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.cd_title = data.title
            transaction.cd_value = data.value as NSDecimalNumber
            transaction.cd_identifier = UUID()
            let date = CalendarDateManagedObject.createEntity(inContext: self.context)
            date.update(with: data.date)
            transaction.date = date
            transaction.category = coreDataCategory
            self.context.save(with: nil)
            self.postNotificationWithCurrentTransactions()
        }
    }
    
    internal func remove(transaction: TransactionProtocol) {
        guard let coreDataTransaction = transaction as? TransactionManagedObject else { return }
        context.performAndWait {
            self.context.delete(coreDataTransaction)
            self.context.save(with: nil)
            self.postNotificationWithCurrentTransactions()
        }
    }
    
    private func allTransactions() throws -> [TransactionManagedObject] {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }
    
    internal func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken {
        
        #warning("temporary hack")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.postNotificationWithCurrentTransactions()
        }
        
        return notificationCenter.observeTransactionsDidChange(callback: { (notification) in
            callback(notification.transactions)
        })
    }
    
    private func postNotificationWithCurrentTransactions() {
        do {
            let notification = TransactionNotification(transactions: try allTransactions())
            notificationCenter.postTransactionsDidChange(notification: notification)
        } catch {
            
        }
    }
}

private class TransactionResultsController: ResultsController<TransactionProtocol> {
    
    private let controller: CoreDataResultsController<TransactionManagedObject>
    
    init(frc: NSFetchedResultsController<TransactionManagedObject>) {
        self.controller = CoreDataResultsController(frc: frc)
    }
    
    override var delegate: ResultsControllerDelegate? {
        get { return controller.delegate }
        set { controller.delegate = newValue }
    }
    
    override func loadData() throws {
        try controller.loadData()
    }
    
    override func object(at indexPath: IndexPath) -> TransactionProtocol {
        return controller.object(at: indexPath)
    }
    
    override func objectsIn(section: Int) -> [TransactionProtocol]? {
        return controller.objectsIn(section: section)
    }
    
    override var sectionsCount: Int {
        return controller.sectionsCount
    }
}


