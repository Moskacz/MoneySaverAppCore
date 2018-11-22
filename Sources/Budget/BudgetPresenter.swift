//
//  BudgetPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation
import Charts

public protocol BudgetPresenterProtocol: class {
    func requestBudgetAmountEdit()
    func saveBudget(amount: Decimal)
    func loadData()
    func dataUpdated(budget: BudgetProtocol, expenses: [TransactionProtocol])
}

internal class BudgetPresenter: BudgetPresenterProtocol {
    
    private let interactor: BudgetInteractorProtocol
    private let routing: BudgetRoutingProtocol
    private let chartsDataProcessor: BudgetChartsDataProcessor
    
    weak var view: BudgetUIProtocol?
    
    init(interactor: BudgetInteractorProtocol,
         routing: BudgetRoutingProtocol,
         chartsDataProcessor: BudgetChartsDataProcessor) {
        self.interactor = interactor
        self.routing = routing
        self.chartsDataProcessor = chartsDataProcessor
    }
    
    func requestBudgetAmountEdit() {
        routing.presentBudgetAmountEditor(presenter: self)
    }
    
    func saveBudget(amount: Decimal) {
        interactor.saveBudget(amount: amount)
    }
    
    func loadData() {
        interactor.loadData()
    }
    
    func dataUpdated(budget: BudgetProtocol, expenses: [TransactionProtocol]) {
        let budgetData = budgetPieChartData(budget: budget.budgetValue, expenses: expenses.sum)
        view?.showBudgetPieChart(with: budgetData)
        let spendingsData = spendingsChartData(budget: budget.budgetValue, transactions: expenses)
        view?.showSpendingsChart(with: spendingsData)
    }
    
    // MARK: Chart data
    
    private func budgetPieChartData(budget: Decimal, expenses: Decimal) -> PieChartData {
        let spentMoneyEntry = PieChartDataEntry(value: -expenses.doubleValue, label: "Spent")
        let toSpent = max(budget + expenses, 0)
        let toSpentMoneyEntry = PieChartDataEntry(value: toSpent.doubleValue, label: "Left")
        let dataSet = PieChartDataSet(values: [spentMoneyEntry, toSpentMoneyEntry], label: nil)
        dataSet.colors = [AppColor.red.value, AppColor.green.value]
        return PieChartData(dataSet: dataSet)
    }
    
    private func spendingsChartData(budget: Decimal, transactions: [TransactionProtocol]) -> CombinedChartData {
        let data = CombinedChartData()
        data.barData = estimatedSpendingsChartData(budget: budget)
        data.lineData = actualSpendingsChartData(transactions: transactions)
        return data
    }
    
    private func estimatedSpendingsChartData(budget: Decimal) -> BarChartData {
        let entries = chartsDataProcessor.estimatedSpendings(budgetValue: budget).map {
            BarChartDataEntry(x: Double($0.x), y: $0.y.doubleValue)
        }
        
        let dataSet = BarChartDataSet(values: entries, label: "Estimated spendings")
        dataSet.colors = [AppColor.green.value]
        dataSet.drawValuesEnabled = false
        return BarChartData(dataSet: dataSet)
    }
    
    private func actualSpendingsChartData(transactions: [TransactionProtocol]) -> LineChartData {
        let entries = chartsDataProcessor.incrementalDailyExpenses(transactions: transactions).map {
            ChartDataEntry(x: Double($0.x), y: $0.y.doubleValue)
        }
        
        let dataSet = LineChartDataSet(values: entries, label: "Actual spendings")
        dataSet.colors = [AppColor.red.value]
        dataSet.mode = .linear
        dataSet.lineWidth = 5
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        return LineChartData(dataSet: dataSet)
    }
}
