//
//  FakeUserPreferences.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import Foundation
@testable import MoneySaverAppCore

class FakeUserPreferences: UserPreferences {
    
    private var dateRangeStub: DateRange!
    private var statsGroupingStub: TransactionsGrouping!
    
    var dateRange: DateRange {
        get { return dateRangeStub }
        set { dateRangeStub = newValue }
    }
    
    var statsGrouping: TransactionsGrouping {
        get { return statsGroupingStub }
        set { statsGroupingStub = newValue }
    }
    
}
