//
//  StatsChartsDateFormatterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08/01/2019.
//

import XCTest
@testable import MoneySaverAppCore

class StatsChartsDateFormatterTests: XCTestCase {

    private var sut: StatsChartsDateFormatter!
    private var calendar: CalendarProtocol!
    
    override func setUp() {
        calendar = Calendar.current
        sut = StatsChartsDateFormatter(grouping: .monthOfEra, calendar: calendar)
    }

    override func tearDown() {
        calendar = nil
        sut = nil
    }

    func test_stringForValue_monthOfEra() {
        sut.grouping = .monthOfEra
        let monthOfEra = 24217 // 01.2019
        let str = sut.stringForValue(Double(monthOfEra), axis: nil)
        XCTAssertEqual(str, "01.2019")
    }
    
    func test_stringForValue_dayOfEra() {
        sut.grouping = .dayOfEra
        let dayOfEra = 737067 // 08.01.2019
        let str = sut.stringForValue(Double(dayOfEra), axis: nil)
        XCTAssertEqual(str, "08.01.2019")
    }
}
