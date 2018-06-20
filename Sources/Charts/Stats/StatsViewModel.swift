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
    
    public init(repository: TransactionsRepository,
                chartsDataProcessor: StatsChartsDataProcessor,
                userPreferences: UserPreferences) {
        self.repository = repository
        self.chartsDataProcessor = chartsDataProcessor
        self.userPreferences = userPreferences
        self.selectedGroupingIntex = availableGroupings.index(of: userPreferences.statsGrouping) ?? 0
    }
    
    var groupingItems: [SegmentedControlItem] {
        return availableGroupings.map { SegmentedControlItem.text($0.description) }
    }
    
    var selectedGroupingIntex: Int {
        didSet {
            userPreferences.statsGrouping = availableGroupings[selectedGroupingIntex]
        }
    }
}
