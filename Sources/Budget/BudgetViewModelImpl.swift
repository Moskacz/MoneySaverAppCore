//
//  BudgetViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
//

import Foundation
import Charts

internal final class BudgetViewModelImpl: BudgetViewModel {
    
    internal weak var delegate: BudgetViewModelDelegate?
    
    private let budgetRepository: BudgetRepository
    private let transactionsRepository: TransactionsRepository
    private let chartsDataProcessor: BudgetChartsDataProcessor
    private let calendar: CalendarProtocol
    private var observationTokens = [ObservationToken]()
    
    public init(budgetRepository: BudgetRepository,
                transactionsRepository: TransactionsRepository,
                chartsDataProcessor: BudgetChartsDataProcessor,
                calendar: CalendarProtocol) {
        self.budgetRepository = budgetRepository
        self.transactionsRepository = transactionsRepository
        self.chartsDataProcessor = chartsDataProcessor
        self.calendar = calendar
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        let transactionsToken = transactionsRepository.observeTransactionsChanged { transactions in
            
        }
        
        let budgetToken = budgetRepository.observeBudgetChanged { budget in
            
        }
        
        observationTokens = [transactionsToken, budgetToken]
    }
    
    private func updateBudgetData(transactions: [TransactionProtocol], budget: Double) {
        let thisMonthExpenses = transactions.expenses.with(monthOfEra: calendar.nowCalendarDate.monthOfEra)
        delegate?.budget(viewModel: self, didUpdateBudget: budgetPieChartData(budget: budget, expenses: thisMonthExpenses.sum))
        delegate?.budget(viewModel: self, didUpdateSpendings: spendingsChartData(budget: budget, transactions: thisMonthExpenses))
    }
    
    // MARK: Chart data
    
    private func budgetPieChartData(budget: Double, expenses: Double) -> PieChartData {
        let spentMoneyEntry = PieChartDataEntry(value: -expenses, label: "Spent")
        let toSpent = max(budget + expenses, 0)
        let toSpentMoneyEntry = PieChartDataEntry(value: toSpent, label: "Left")
        let dataSet = PieChartDataSet(values: [spentMoneyEntry, toSpentMoneyEntry], label: nil)
//        dataSet.colors = [AppColor.red.value, AppColor.green.value]
        dataSet.colors = [NSUIColor.red, NSUIColor.green]
        return PieChartData(dataSet: dataSet)
    }
    
    private func spendingsChartData(budget: Double, transactions: [TransactionProtocol]) -> CombinedChartData {
        let data = CombinedChartData()
        data.barData = estimatedSpendingsChartData(budget: budget)
        data.lineData = actualSpendingsChartData(transactions: transactions)
        return data
    }
    
    private func estimatedSpendingsChartData(budget: Double) -> BarChartData {
        let entries = chartsDataProcessor.estimatedSpendings(budgetValue: budget).map {
            BarChartDataEntry(x: Double($0.x), y: $0.y)
        }
        
        let dataSet = BarChartDataSet(values: entries, label: "Estimated spendings")
//        barDataSet.colors = [AppColor.green.value]
        dataSet.drawValuesEnabled = false
        return BarChartData(dataSet: dataSet)
    }
    
    private func actualSpendingsChartData(transactions: [TransactionProtocol]) -> LineChartData {
        let entries = chartsDataProcessor.incrementalDailyExpenses(transactions: transactions).map {
            ChartDataEntry(x: Double($0.x), y: $0.y)
        }
        
        let dataSet = LineChartDataSet(values: entries, label: "Actual spendings")
//        dataSet.colors = [AppColor.red.value]
        dataSet.mode = .linear
        dataSet.lineWidth = 5
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        return LineChartData(dataSet: dataSet)
    }
}
