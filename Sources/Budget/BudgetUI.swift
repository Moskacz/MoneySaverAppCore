//
//  BudgetUI.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation
import Charts

public protocol BudgetUI {
    func showBudgetNotSetup()
    func showBudgetPieChart(with data: PieChartData)
    func showSpendingsChart(with data: BarChartData)
}
