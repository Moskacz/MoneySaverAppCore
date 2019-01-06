//
//  CalendarProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 13.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public protocol CalendarProtocol {
    var now: Date { get }
    var nowCalendarDate: CalendarDateProtocol { get }
    func calendarDate(from date: Date) -> CalendarDateProtocol
    func dayOfEraOf(date: Date) -> Int
    func weekOfEraOf(date: Date) -> Int
    func monthOfEraOf(date: Date) -> Int
    func yearOf(date: Date) -> Int
    func monthName(forDate date: Date) -> String
    func yearName(forDate date: Date) -> String
    func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int>
    func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date)
}

public struct CalendarDate: CalendarDateProtocol {
    public let calendarIdentifier: String?
    public let dayOfEra: Int32
    public let dayOfMonth: Int32
    public let dayOfYear: Int32
    public let era: Int32
    public let weekOfEra: Int32
    public let weekOfMonth: Int32
    public let weekOfYear: Int32
    public let year: Int32
    public let timeInterval: Double
    public let monthOfYear: Int32
    public let monthOfEra: Int32
    
    public init(calendarIdentifier: String?,
                dayOfEra: Int32,
                dayOfMonth: Int32,
                dayOfYear: Int32,
                era: Int32,
                weekOfEra: Int32,
                weekOfMonth: Int32,
                weekOfYear: Int32,
                year: Int32,
                timeInterval: Double,
                monthOfYear: Int32,
                monthOfEra: Int32) {
        self.calendarIdentifier = calendarIdentifier
        self.dayOfEra = dayOfEra
        self.dayOfMonth = dayOfMonth
        self.dayOfYear = dayOfYear
        self.era = era
        self.weekOfEra = weekOfEra
        self.weekOfMonth = weekOfMonth
        self.weekOfYear = weekOfYear
        self.year = year
        self.timeInterval = timeInterval
        self.monthOfYear = monthOfYear
        self.monthOfEra = monthOfEra
    }
}

extension Calendar: CalendarProtocol {
    
    public var now: Date {
        return Date()
    }
    
    public var nowCalendarDate: CalendarDateProtocol {
        return calendarDate(from: now)
    }
    
    public func calendarDate(from date: Date) -> CalendarDateProtocol {
        return CalendarDate(calendarIdentifier: identifier.stringIdentifier,
                            dayOfEra: Int32(dayOfEraOf(date: date)),
                            dayOfMonth: Int32(component(.day, from: date)),
                            dayOfYear: Int32(ordinality(of: .day, in: .year, for: date) ?? -1),
                            era: Int32(component(.era, from: date)),
                            weekOfEra: Int32(weekOfEraOf(date: date)),
                            weekOfMonth: Int32(component(.weekOfMonth, from: date)),
                            weekOfYear: Int32(component(.weekOfYear, from: date)),
                            year: Int32(component(.year, from: date)),
                            timeInterval: date.timeIntervalSince1970,
                            monthOfYear: Int32(component(.month, from: date)),
                            monthOfEra: Int32(ordinality(of: .month, in: .era, for: date) ?? -1))
    }
    
    public func dayOfEraOf(date: Date) -> Int {
        return ordinality(of: .day, in: .era, for: date) ?? -1
    }
    
    public func weekOfEraOf(date: Date) -> Int {
        return ordinality(of: .weekOfYear, in: .era, for: date) ?? -1
    }
    
    public func monthOfEraOf(date: Date) -> Int {
        return ordinality(of: .month, in: .era, for: date) ?? -1
    }
    
    public func yearOf(date: Date) -> Int {
        return component(.year, from: date)
    }
    
    public func monthName(forDate date: Date) -> String {
        let month = component(.month, from: date) - 1;
        return standaloneMonthSymbols[month].firstUppercased
    }
    
    public func yearName(forDate date: Date) -> String {
        return String(component(.year, from: date))
    }
    
    public func daysInMonthRange(forDate date: Date) -> CountableClosedRange<Int> {
        guard let range = range(of: .day, in: .month, for: date) else {
            return 0...0
        }
        return CountableClosedRange(range)
    }
    
    public func beginEndDaysOfWeek(forDate date: Date) -> (start: Date, end: Date) {
        var startDate: Date = Date()
        var interval: TimeInterval = 1
        _ = self.dateInterval(of: .weekOfMonth,
                              start: &startDate,
                              interval: &interval,
                              for: date)
        let endDate = startDate.addingTimeInterval(interval-1)
        return (startDate, endDate)
    }
}
