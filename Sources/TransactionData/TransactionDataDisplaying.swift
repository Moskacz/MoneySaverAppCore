//
//  TransactionDataDisplaying.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.09.2018.
//

import Foundation

public protocol TransactionDataDisplaying {
    func display(error: TransactionDataViewError)
    func set(title: String?)
    func set(amount: String?)
    func set(date: Date)
    func set(formattedDate: String?)
}
