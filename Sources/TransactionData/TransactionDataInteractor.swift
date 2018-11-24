//
//  TransactionDataInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import Foundation

protocol TransactionDataInteractorProtocol {
    func transactionData(with title: String, amount: Decimal, date: Date) -> TransactionData
}
