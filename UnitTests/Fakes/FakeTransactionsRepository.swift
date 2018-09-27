//
//  FakeTransactionsRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import Foundation
import CoreData
@testable import MoneySaverAppCore
import MMFoundation

class FakeTransactionsRepository: TransactionsRepository {
    
    var allTransactionsResultController: ResultsController<TransactionProtocol> { fatalError() }
    
    var transactionChangedCallback: (([TransactionProtocol]) -> Void)?
    
    func addTransaction(data: TransactionData, category: TransactionCategoryProtocol) {
        fatalError()
    }
    
    func remove(transaction: TransactionProtocol) {
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
