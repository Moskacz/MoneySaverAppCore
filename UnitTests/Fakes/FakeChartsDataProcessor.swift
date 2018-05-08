//
//  FakeChartsDataProcessor.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public class FakeChartsDataProcessor: ChartsDataProcessor {
    
    public init() {}
    
    public func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue] {
        fatalError()
    }
    
    public func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        fatalError()
    }
}
