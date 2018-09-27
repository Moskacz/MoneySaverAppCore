//
//  FakeCalendar.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverAppCore

class FakeCalendar: CalendarProtocol {
    
    var calendar = Calendar.current
    
    var nowToReturn: Date!
    var nowCalendarDateToReturn: CalendarDateProtocol!
    var daysInMonthRangeToReturn: CountableClosedRange<Int>!
    var dayOfEraOfDateToReturn: Int!
    var weekOfEraOfDateToReturn: Int!
    var monthOfEraOfDateToReturn: Int!
    var yearOfDateToReturn: Int!
    var monthNameToReturn: String!
    var yearNameToReturn: String!
    var beginEndDaysOfWeekToReturn: (Date, Date)!
    
    var now: Date {
        return nowToReturn
    }
    
    var nowCalendarDate: CalendarDateProtocol {
        return nowCalendarDateToReturn
    }
    
    func calendarDate(from date: Date) -> CalendarDateProtocol {
        return calendar.calendarDate(from: date)
    }
    
    func dayOfEraOf(date: Date) -> Int {
        return dayOfEraOfDateToReturn
    }
    
    func weekOfEraOf(date: Date) -> Int {
        return weekOfEraOfDateToReturn
    }
    
    func monthOfEraOf(date: Date) -> Int {
        return monthOfEraOfDateToReturn
    }
    
    func yearOf(date: Date) -> Int {
        return yearOfDateToReturn
    }
    
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int> {
        return daysInMonthRangeToReturn
    }
    
    func daysInMonth(forDate date: Date) -> Int {
        fatalError()
    }
    
    func monthName(forDate date: Date) -> String {
        return monthNameToReturn
    }
    
    func yearName(forDate date: Date) -> String {
        return yearNameToReturn
    }

    
    func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date) {
        return beginEndDaysOfWeekToReturn
    }
}
