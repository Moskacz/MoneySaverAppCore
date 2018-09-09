//
//  TransactionDataCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.09.2018.
//

import Foundation

public protocol TransactionDataViewCoordinator {
    var display: TransactionDataDisplaying? { get set }
    func set(title: String?, value: String?, date: Date) throws
}

public struct TransactionDataViewModel {
    let title: String
    let amount: String
    let date: String
}
