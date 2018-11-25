//
//  StatsViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
//

import Foundation
import Charts
import MMFoundation

internal final class StatsViewModelImpl: StatsViewModel {
    
    internal weak var delegate: StatsViewModelDelegate?
    
    private let repository: TransactionsRepository
    private let chartsDataProcessor: StatsChartsDataProcessor
    private let userPreferences: UserPreferences
    private let availableGroupings: [TransactionsGrouping] = [.dayOfEra, .weekOfEra, .monthOfEra]
    private var observationToken: ObservationToken?
    private var transactions = [TransactionProtocol]()
    
    internal init(repository: TransactionsRepository,
                chartsDataProcessor: StatsChartsDataProcessor,
                userPreferences: UserPreferences) {
        self.repository = repository
        self.chartsDataProcessor = chartsDataProcessor
        self.userPreferences = userPreferences
        self.selectedGroupingIntex = availableGroupings.index(of: userPreferences.statsGrouping!) ?? 0
        registerForNotifications()
    }
    
    internal var groupingItems: [SegmentedControlItem] {
        return availableGroupings.map { SegmentedControlItem.text($0.description) }
    }
    
    internal var selectedGroupingIntex: Int {
        didSet {
            userPreferences.statsGrouping = selectedGrouping
            if selectedGroupingIntex != oldValue {
                updateExpensesData()
                updateIncomesData()
            }
        }
    }
    
    private var selectedGrouping: TransactionsGrouping {
        return availableGroupings[selectedGroupingIntex]
    }
    
    private func registerForNotifications() {
        observationToken = repository.observeTransactionsChanged(callback: { transactions in
            self.transactions = transactions
            self.updateExpensesData()
            self.updateCategoryExpenseData()
            self.updateIncomesData()
        })
    }
    
    private func updateExpensesData() {
        let plotValues = chartsDataProcessor.expensesGroupedBy(grouping: selectedGrouping, transactions: transactions)
        let entries = plotValues.map { BarChartDataEntry(x: Double($0.x), y: $0.y.doubleValue) }
        let data = BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateExpenses: data)
    }
    
    private func updateCategoryExpenseData() {
        let plotValues = chartsDataProcessor.expensesGroupedByCategories(transactions)
        let entries = plotValues.map { PieChartDataEntry(value: $0.sum.doubleValue, label: $0.categoryName)}
        let data = PieChartData(dataSet: PieChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateCategoryExpenses: data)
    }
    
    private func updateIncomesData() {
        let plotValues = chartsDataProcessor.incomesGroupedBy(grouping: selectedGrouping, transactions: transactions)
        let entries = plotValues.map { BarChartDataEntry(x: $0.y.doubleValue, y: $0.y.doubleValue) }
        let data = BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateIncomes: data)
    }
}
