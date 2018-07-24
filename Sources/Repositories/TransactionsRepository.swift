//
//  TransactionsRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 15.07.2018.
//

import Foundation
import MMFoundation

public struct TransactionData {
    public let title: String
    public let value: Decimal
    public let creationDate: Date
    
    public init(title: String, value: Decimal, creationDate: Date) {
        self.title = title
        self.value = value
        self.creationDate = creationDate
    }
}

internal protocol TransactionsRepository {
    var allTransactionsResultController: ResultsController<TransactionProtocol> { get }
    func addTransaction(data: TransactionData, category: TransactionCategoryManagedObject)
    func remove(transaction: TransactionManagedObject)
    func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken
}
