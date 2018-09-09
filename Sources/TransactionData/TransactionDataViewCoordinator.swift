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

public enum TransactionDataViewError: Error {
    case invalidTitle
    case invalidValue
}

