//
//  StatsViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
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
