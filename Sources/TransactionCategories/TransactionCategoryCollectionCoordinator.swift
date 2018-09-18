//
//  TransactionCategoryCollectionCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 16.09.2018.
//

import Foundation

public protocol TransactionCategoryCollectionCoordinator {
    var display: TransactionCategoryCollectionDisplaying? { set get }
}
