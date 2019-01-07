//
//  StatsChartsDateFormatter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07/01/2019.
//

import Foundation
import Charts

internal final class StatsChartsDateFormatter {
    
    var grouping: TransactionsGrouping
    
    init(grouping: TransactionsGrouping) {
        self.grouping = grouping
    }
}

extension StatsChartsDateFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        switch grouping {
        case .dayOfEra:
            fatalError()
        case .weekOfEra:
            fatalError()
        case .monthOfEra:
            fatalError()
        }
    }
}
