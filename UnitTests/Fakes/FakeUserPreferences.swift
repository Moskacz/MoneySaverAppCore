//
//  FakeUserPreferences.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import Foundation
@testable import MoneySaverAppCore

class FakeUserPreferences: UserPreferences {
    
    var initialDataInsertDone: Bool = false
    var dateRange: DateRange?
    var statsGrouping: TransactionsGrouping?
    
}
