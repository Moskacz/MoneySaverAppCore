//
//  AddTransactionFlow.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19.09.2018.
//

import Foundation

public protocol AddTransactionFlow: class {
    var transactionData: TransactionData? { get set }
    var category: TransactionCategoryProtocol { get set }
}

