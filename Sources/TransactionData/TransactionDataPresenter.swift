//
//  TransactionDataPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import Foundation

public protocol TransactionDataPresenterProtocol {
    func set(transactionTitle: String?)
    func set(transactionAmount: String?)
    func set(transactionDate: Date?)
    func nextTapped()
}




