//
//  ChartsDataProcessor.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public protocol BudgetChartsDataProcessor {
    func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue]
    func estimatedSpendings(budgetValue: Double) -> [PlotValue]
}

extension ChartsDataProcessor: BudgetChartsDataProcessor {
    
    public func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue] {
        let sortedExpeneses = expenses.sorted { (lhs, rhs) -> Bool in
            return lhs.date < rhs.date
        }
        
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let value = sortedExpeneses.reduce(0, { (sum, dailyValue) -> Double in
                guard dailyValue.date <= day else { return sum }
                return sum - dailyValue.value
            })
            return PlotValue(x: day, y: value)
        }
    }
    
    public func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let dailySpending = budgetValue * Double(day)  / Double(daysRange.upperBound)
            return PlotValue(x: day, y: dailySpending)
        }
    }
}
