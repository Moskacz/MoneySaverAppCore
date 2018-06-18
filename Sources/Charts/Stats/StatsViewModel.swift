//
//  StatsViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.06.2018.
//

import Foundation
import Charts

public protocol StatsViewModelDelegate: class {
    func dataUpdated()
}

public class StatsViewModel {
    
    private let repository: TransactionsRepository
    public weak var delegate: StatsViewModelDelegate?
    
    public init(repository: TransactionsRepository) {
        self.repository = repository
    }
}
