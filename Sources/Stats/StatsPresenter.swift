//
//  StatsPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation

public protocol StatsPresenterProtocol {
    var selectedGroupingIndex: Int { get set }
    func loadData()
    func dataLoaded(transactions: [TransactionProtocol])
}

