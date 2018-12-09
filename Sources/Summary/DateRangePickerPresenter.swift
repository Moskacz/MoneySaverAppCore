//
//  DateRangePickerPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09/12/2018.
//

import Foundation

public struct DateRangeItem {
    public let title: String
    public let range: DateRange
}

public protocol DateRangePickerPresenterProtocol {
    var items: [DateRangeItem] { get }
}

internal class DateRangePickerPresenter {

    private let calendar: CalendarProtocol
    
    internal init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
}

extension DateRangePickerPresenter: DateRangePickerPresenterProtocol {
    
    var items: [DateRangeItem] {
        let nowDate = calendar.now
        let today = DateRangeItem(title: "Today", range: .today)
        let thisMonth = DateRangeItem(title: calendar.monthName(forDate: nowDate), range: .thisMonth)
        let thisYear = DateRangeItem(title: calendar.yearName(forDate: nowDate), range: .thisYear)
        let allTime = DateRangeItem(title: "All", range: .allTime)
        return [today, thisWeekRange, thisMonth, thisYear, allTime]
    }
    
    private var thisWeekRange: DateRangeItem {
        let formatter = DateFormatters.formatter(forType: .shortDate)
        let dates = calendar.beginEndDaysOfWeek(forDate: calendar.now)
        let title = "Week " + formatter.string(from: dates.start) + " - " + formatter.string(from: dates.end
        return DateRangeItem(title: title, range: .thisWeek)
    }
}
