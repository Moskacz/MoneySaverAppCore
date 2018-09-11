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

public struct TransactionDataViewError: Error, OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let invalidValue = TransactionDataViewError(rawValue: 1)
    static let missingValue = TransactionDataViewError(rawValue: 1 << 1)
    static let missingTitle = TransactionDataViewError(rawValue: 1 << 2)
}



