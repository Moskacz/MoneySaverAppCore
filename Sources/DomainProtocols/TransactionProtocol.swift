//
//  Transaction.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public protocol TransactionProtocol: UniqueIdentifiable {
    var title: String { get }
    var value: Decimal { get }
    var transactionCategory: TransactionCategoryProtocol? { get }
    var transactionDate: CalendarDateProtocol? { get }
}

