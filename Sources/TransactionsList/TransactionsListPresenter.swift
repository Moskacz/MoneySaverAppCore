//
//  TransactionsListPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation

public protocol TransactionsListPresenterProtocol {
    var display: TransactionsListUI { get set }
    var interactor: TransactionsListInteractor { get set }
    func loadData()
}


