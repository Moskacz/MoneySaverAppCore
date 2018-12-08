//
//  TransactionDataDisplaying.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.09.2018.
//

import Foundation

public protocol TransactionDataUI: class {
    func display(error: TransactionDataViewError)
    func set(title: String?)
    func set(amount: String?)
    func set(date: String?)
    func pick(date: Date)
}
