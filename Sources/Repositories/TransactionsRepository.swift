//
//  TransactionsRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 15.07.2018.
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
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
    func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken
}
