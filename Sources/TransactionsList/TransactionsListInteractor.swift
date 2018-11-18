//
//  TransactionsListInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation

public protocol TransactionsListInteractor {
    var presenter: TransactionsListPresenterProtocol { get set }
}
