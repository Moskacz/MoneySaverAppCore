//
//  DateRangePickerPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09/12/2018.
//

import XCTest
@testable import MoneySaverAppCore

class DateRangePickerPresenterTests: XCTestCase {
    
    func test_items() {
        let calendar = FakeCalendar()
        let date = Date(timeIntervalSince1970: 0)
        calendar.nowToReturn = date
        calendar.monthNameToReturn = "January"
        calendar.yearNameToReturn = "1970"
        calendar.beginEndDaysOfWeekToReturn = (date, date)
        let sut = DateRangePickerPresenter(calendar: calendar)
        XCTAssertEqual(sut.items[0].title, "Today")
        XCTAssertEqual(sut.items[1].title, "Week 01.01.1970 - 01.01.1970")
        XCTAssertEqual(sut.items[2].title, "January")
        XCTAssertEqual(sut.items[3].title, "1970")
        XCTAssertEqual(sut.items[4].title, "All")
        XCTAssertEqual(sut.items.count, 5)
    }
}
