//
//  StatsViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.06.2018.
//

import Foundation
import Charts

public protocol StatsViewModelDelegate: class {
    func stats(viewModel: StatsViewModel, didUpdateExpenses data: BarChartData)
    func stats(viewModel: StatsViewModel, didUpdateIncomes data: BarChartData)
    func stats(viewModel: StatsViewModel, didUpdateCategoryExpenses data: PieChartData)
}

public protocol StatsViewModel {
    var delegate: StatsViewModelDelegate? { get set }
    var groupingItems: [SegmentedControlItem] { get }
    var selectedGroupingIntex: Int { get set }
}

class StatsViewModelImpl: StatsViewModel {
    
    public weak var delegate: StatsViewModelDelegate?
    
    private let repository: TransactionsRepository
    private let chartsDataProcessor: StatsChartsDataProcessor
    private let userPreferences: UserPreferences
    private let availableGroupings: [TransactionsGrouping] = [.dayOfEra, .weekOfEra, .monthOfEra]
    private var observationToken: ObservationToken?
    private var transactions = [TransactionProtocol]()
    
    public init(repository: TransactionsRepository,
                chartsDataProcessor: StatsChartsDataProcessor,
                userPreferences: UserPreferences) {
        self.repository = repository
        self.chartsDataProcessor = chartsDataProcessor
        self.userPreferences = userPreferences
        self.selectedGroupingIntex = availableGroupings.index(of: userPreferences.statsGrouping) ?? 0
        registerForNotifications()
    }
    
    var groupingItems: [SegmentedControlItem] {
        return availableGroupings.map { SegmentedControlItem.text($0.description) }
    }
    
    var selectedGroupingIntex: Int {
        didSet {
            userPreferences.statsGrouping = selectedGrouping
            if selectedGroupingIntex != oldValue {
                updateExpensesData()
                updateExpensesData()
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
        let entries = plotValues.map { BarChartDataEntry(x: Double($0.x), y: $0.y) }
        let data = BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateExpenses: data)
    }
    
    private func updateCategoryExpenseData() {
        let plotValues = chartsDataProcessor.expensesGroupedByCategories(transactions)
        let entries = plotValues.map { PieChartDataEntry(value: $0.sum, label: $0.categoryName)}
        let data = PieChartData(dataSet: PieChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateCategoryExpenses: data)
    }
    
    private func updateIncomesData() {
        let plotValues = chartsDataProcessor.incomesGroupedBy(grouping: selectedGrouping, transactions: transactions)
        let entries = plotValues.map { BarChartDataEntry(x: Double($0.x), y: $0.y) }
        let data = BarChartData(dataSet: BarChartDataSet(values: entries, label: nil))
        delegate?.stats(viewModel: self, didUpdateIncomes: data)
    }
}
