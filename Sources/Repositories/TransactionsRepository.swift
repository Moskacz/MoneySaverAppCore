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
    public let date: CalendarDateProtocol
    
    public init(title: String, value: Decimal, date: CalendarDateProtocol) {
        self.title = title
        self.value = value
        self.date = date
    }
}

internal protocol TransactionsRepository {
    func transactionsResultsController(transactionsMonthOfEra: Int) -> ResultsController<TransactionProtocol>
    var allTransactionsResultController: ResultsController<TransactionProtocol> { get }
    func addTransaction(data: TransactionData, category: TransactionCategoryProtocol)
    func remove(transaction: TransactionProtocol)
    func observeTransactionsChanged(callback: @escaping ([TransactionProtocol]) -> Void) -> ObservationToken
}
