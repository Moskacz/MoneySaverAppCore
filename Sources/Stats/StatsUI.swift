//
//  StatsUI.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import Charts
import MMFoundation

public protocol StatsUI {
    func setGrouping(items: [SegmentedControlItem])
    func selectGrouping(index: Int)
    func showExpenses(data: BarChartData)
    func showIncomes(data: BarChartData)
    func showCategoryExpenses(data: PieChartData)
}
