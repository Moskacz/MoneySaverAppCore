//
//  TransactionCategoriesCollectionCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.09.2018.
//

import Foundation

public protocol TransactionCategoriesCollectionCoordinator {
    var display: TransactionCategoriesDisplaying? { get set }
}
