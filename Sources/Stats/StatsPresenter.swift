//
//  StatsPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import MMFoundation
import Charts

public protocol StatsPresenterProtocol: class {
    var selectedGroupingIndex: Int { get set }
    func start()
    func dataLoaded(transactions: [TransactionProtocol])
}

internal class StatsPresenter {
    
    private let interactor: StatsInteractorProtocol
    private let chartsDataProcessor: StatsChartsDataProcessor
    private let availableGroupings: [TransactionsGrouping] = [.dayOfEra, .weekOfEra, .monthOfEra]
    private var selectedGrouping: TransactionsGrouping
    
    weak var view: StatsUIProtocol?
    
    internal init(interactor: StatsInteractorProtocol,
                  chartsDataProcessor: StatsChartsDataProcessor) {
        self.interactor = interactor
        self.chartsDataProcessor = chartsDataProcessor
        self.selectedGrouping = interactor.preferredGrouping ?? .monthOfEra
    }
}

extension StatsPresenter: StatsPresenterProtocol {
    
    var selectedGroupingIndex: Int {
        get {
            return availableGroupings.index(of: selectedGrouping)!
        }
        set {
            selectedGrouping = availableGroupings[newValue]
            interactor.preferredGrouping = selectedGrouping
            interactor.loadTransactions()
        }
    }
    
    func start() {
        view?.setGrouping(items: availableGroupings.map { SegmentedControlItem.text($0.description) })
        view?.selectGrouping(index: selectedGroupingIndex)
        interactor.loadTransactions()
    }
    
    func dataLoaded(transactions: [TransactionProtocol]) {
        view?.showExpenses(data: expensesData(transactions: transactions))
        view?.showIncomes(data: incomesData(transactions: transactions))
        view?.showCategoryExpenses(data: categoryExpensesData(transactions: transactions))
    }
    
    // MARK: Charts data
    
    private func expensesData(transactions: [TransactionProtocol]) -> BarChartData {
        let plotValues = chartsDataProcessor.expensesGroupedBy(grouping: selectedGrouping,
                                                               transactions: transactions)
        let entries = plotValues.map { BarChartDataEntry(x: Double($0.x), y: $0.y.doubleValue) }
        return BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
    }
    
    private func categoryExpensesData(transactions: [TransactionProtocol]) -> PieChartData {
        let plotValues = chartsDataProcessor.expensesGroupedByCategories(transactions)
        let entries = plotValues.map { PieChartDataEntry(value: $0.sum.doubleValue, label: $0.categoryName)}
        return PieChartData(dataSet: PieChartDataSet(values: entries, label: nil))
    }
    
    private func incomesData(transactions: [TransactionProtocol]) -> BarChartData {
        let plotValues = chartsDataProcessor.incomesGroupedBy(grouping: selectedGrouping,
                                                              transactions: transactions)
        let entries = plotValues.map { BarChartDataEntry(x: $0.y.doubleValue, y: $0.y.doubleValue) }
        return BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
    }
}
