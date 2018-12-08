//
//  TransactionDataRouting.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import Foundation

public protocol TransactionDataRouting: class {
    func showTransactionCategoriesPicker(transactionData: TransactionData)
}
