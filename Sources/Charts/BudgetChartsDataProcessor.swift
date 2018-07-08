//
//  ChartsDataProcessor.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 22.11.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

internal protocol BudgetChartsDataProcessor {
    func incrementalDailyExpenses(transactions: [TransactionProtocol]) -> [PlotValue]
    func estimatedSpendings(budgetValue: Double) -> [PlotValue]
}

extension ChartsDataProcessor: BudgetChartsDataProcessor {
    
    func incrementalDailyExpenses(transactions: [TransactionProtocol]) -> [PlotValue] {
        let dailyExpenses = transactions.expenses.grouped { $0.transactionDate?.dayOfEra }.map { (day, expenses) -> PlotValue in
            return PlotValue(x: Int(day), y: expenses.sum)
        }.sorted { $0.x < $1.x }
        
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            var expensesToDay = Double(0)
            for expense in dailyExpenses {
                guard expense.x <= day else { break }
                expensesToDay += expense.y
            }
            return PlotValue(x: day, y: expensesToDay)
        }
    }
    
    internal func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        let daysRange = calendar.daysInMonthRange(forDate: calendar.now)
        return daysRange.map { day in
            let dailySpending = budgetValue * Double(day)  / Double(daysRange.upperBound)
            return PlotValue(x: day, y: dailySpending)
        }
    }
}
