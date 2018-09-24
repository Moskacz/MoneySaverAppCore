//
//  TransactionCellViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

internal class TransactionCellViewModelImpl: TransactionCellViewModel {
    
    private let transaction: TransactionProtocol
    private let formatter: DateFormatter
    
    internal init(transaction: TransactionProtocol, formatter: DateFormatter) {
        self.transaction = transaction
        self.formatter = formatter
    }
    
    var titleText: String? {
        return NSDecimalNumber(decimal: transaction.value).stringValue
    }
    
    var descriptionText: String? {
        return transaction.title
    }
    
    var categoryIcon: Image? {
        return transaction.transactionCategory?.image
    }
    
    var dateText: String? {
        guard let timestamp = transaction.transactionDate?.timeInterval else { return nil }
        let date = Date(timeIntervalSince1970: timestamp)
        return formatter.string(from: date)
    }
    
    var indicatorGradient: Gradient? {
        if transaction.value >= 0 {
            return AppGradient.positiveValueTransaction.value
        } else {
            return AppGradient.negativeValueTransaction.value
        }
    }
}
