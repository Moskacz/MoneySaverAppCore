//
//  FakeTransactionsRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import Foundation
import CoreData
@testable import MoneySaverAppCore

class FakeTransactionsRepository: TransactionsRepository {
    
    var transactionChangedCallback: (([TransactionProtocol]) -> Void)?
    
    var allTransactionsFRC: NSFetchedResultsController<TransactionManagedObject> {
        fatalError()
    }
    
    var context: NSManagedObjectContext {
        fatalError()
    }
    
    var fetchRequest: NSFetchRequest<TransactionManagedObject> {
        fatalError()
    }
    
    var expensesOnlyPredicate: NSPredicate {
        fatalError()
    }
    
    func predicate(forDateRange range: DateRange) -> NSPredicate? {
        fatalError()
    }
    
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject) {
        fatalError()
    }
    
    func remove(transaction: TransactionManagedObject) {
        fatalError()
    }
    
    func allTransactions() throws -> [TransactionManagedObject] {
        fatalError()
    }
    
    func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken {
        self.transactionChangedCallback = callback
        return ObservationToken(notificationCenter: NotificationCenter.default,
                                token: NSObject(),
                                notificationName: .transactionsDidChange)
    }
}
