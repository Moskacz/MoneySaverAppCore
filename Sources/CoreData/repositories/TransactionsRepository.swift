//
//  TransactionRepository.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 15.04.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

internal struct TransactionData {
    internal let title: String
    internal let value: Decimal
    internal let creationDate: Date
}

internal protocol TransactionsRepository {
    
    var allTransactionsFRC: NSFetchedResultsController<TransactionManagedObject> { get }
    var context: NSManagedObjectContext { get }
    var fetchRequest: NSFetchRequest<TransactionManagedObject> { get }
    var expensesOnlyPredicate: NSPredicate { get }
    
    func predicate(forDateRange range: DateRange) -> NSPredicate?
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
    func allTransactions() throws -> [TransactionManagedObject]
    func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken
}

internal class TransactionsRepositoryImplementation: TransactionsRepository {
    
    internal let context: NSManagedObjectContext
    private let calendar: CalendarProtocol
    private let logger: Logger
    private let notificationCenter: TransactionNotificationCenter
    
    internal init(context: NSManagedObjectContext,
                logger: Logger,
                calendar: CalendarProtocol,
                notificationCenter: TransactionNotificationCenter) {
        self.context = context
        self.logger = logger
        self.calendar = calendar
        self.notificationCenter = notificationCenter
    }
    
    internal var allTransactionsFRC: NSFetchedResultsController<TransactionManagedObject> {
        let request = fetchRequest
        request.includesPropertyValues = true
        request.fetchBatchSize = 20
        
        request.sortDescriptors = [NSSortDescriptor(key: TransactionManagedObject.KeyPath.dayOfEra.rawValue, ascending: false),
                                   NSSortDescriptor(key: TransactionManagedObject.KeyPath.timeInterval.rawValue, ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: TransactionManagedObject.KeyPath.dayOfEra.rawValue,
                                          cacheName: nil)
    }
    
    internal var fetchRequest: NSFetchRequest<TransactionManagedObject> {
        get {
            return TransactionManagedObject.fetchRequest()
        }
    }
    
    internal var expensesOnlyPredicate: NSPredicate {
        get {
            return NSPredicate(format: "value < 0")
        }
    }
    
    internal func predicate(forDateRange range: DateRange) -> NSPredicate? {
        let date = calendar.now
        switch range {
        case .today:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.dayOfEra.rawValue) == \(calendar.dayOfEraOf(date: date))")
        case .thisWeek:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.weekOfEra.rawValue) == \(calendar.weekOfEraOf(date: date))")
        case .thisMonth:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.monthOfEra.rawValue) == \(calendar.monthOfEraOf(date: date))")
        case .thisYear:
            return NSPredicate(format: "\(TransactionManagedObject.KeyPath.year.rawValue) == \(calendar.yearOf(date: date))")
        case .allTime:
            return nil
        }
    }
    
    internal func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        context.performAndWait {
            let transaction = TransactionManagedObject.createEntity(inContext: self.context)
            transaction.title = data.title
            transaction.value = data.value as NSDecimalNumber
            let date = CalendarDateManagedObject.createEntity(inContext: self.context)
            date.update(with: calendar.calendarDate(from: data.creationDate))
            transaction.date = date
            transaction.category = category
            self.context.save(with: nil)
        }
        postNotificationWithCurrentTransactions()
    }
    
    internal func remove(transaction: TransactionManagedObject) {
        context.performAndWait {
            self.context.delete(transaction)
            self.context.save(with: nil)
        }
        postNotificationWithCurrentTransactions()
    }
    
    internal func allTransactions() throws -> [TransactionManagedObject] {
        let request = fetchRequest
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
