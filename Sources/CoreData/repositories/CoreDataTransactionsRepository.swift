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
    
    internal init(context: NSManagedObjectContext,
                logger: Logger,
                notificationCenter: TransactionNotificationCenter) {
        self.context = context
        self.logger = logger
        self.notificationCenter = notificationCenter
    }
    
    internal var allTransactionsResultController: ResultsController<TransactionProtocol> {
        let request: NSFetchRequest<TransactionManagedObject> = TransactionManagedObject.fetchRequest()
        request.includesPropertyValues = true
        request.fetchBatchSize = 20

        request.sortDescriptors = [NSSortDescriptor(key: TransactionManagedObject.KeyPath.dayOfEra.rawValue, ascending: false),
                                   NSSortDescriptor(key: TransactionManagedObject.KeyPath.timeInterval.rawValue, ascending: false)]

        let frc = NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: TransactionManagedObject.KeyPath.dayOfEra.rawValue,
                                          cacheName: nil)
        return TransactionResultsController(frc: frc)
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


