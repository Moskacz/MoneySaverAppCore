//
//  StatsChartsDateFormatter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07/01/2019.
//

import Foundation
import Charts

internal final class StatsChartsDateFormatter {
    
    private let calendar: CalendarProtocol
    var grouping: TransactionsGrouping
    
    private lazy var monthAndYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.yyyy"
        return formatter
    }()
    
    private lazy var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter
    }()
    
    private lazy var dayAndMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.MM"
        return formatter
    }()
    
    init(grouping: TransactionsGrouping, calendar: CalendarProtocol) {
        self.grouping = grouping
        self.calendar = calendar
    }
}

extension StatsChartsDateFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var components = DateComponents()
        
        switch grouping {
        case .dayOfEra: components.day = Int(value)
        case .weekOfEra: components.weekOfYear = Int(value)
        case .monthOfEra: components.month = Int(value)
        }
        
        guard let date = calendar.date(from: components) else { return "" }
        
        switch grouping {
        case .dayOfEra: return shortDateFormatter.string(from: date)
        case .monthOfEra: return monthAndYearFormatter.string(from: date)
        case .weekOfEra:
            let beginEnd = calendar.beginEndDaysOfWeek(forDate: date)
            return [dayAndMonthFormatter.string(from: beginEnd.start),
                    dayAndMonthFormatter.string(from: beginEnd.end)].joined(separator: "-")
        }
    }
}
