//
//  StatsInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation

internal protocol StatsInteractor {
    var preferredGrouping: TransactionsGrouping { get set }
    func loadData()
}
