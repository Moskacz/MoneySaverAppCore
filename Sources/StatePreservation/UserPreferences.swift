//
//  UserPreferences.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public protocol UserPreferences: class {
    var dateRange: DateRange { get set }
    var statsGrouping: TransactionsGrouping { get set }
}

extension UserDefaults: UserPreferences {
    
    private enum PreferenceKey: String {
        case dateRange = "userPreferences_dateRange"
        case statsGrouping = "userPreferences_statsGrouping"
    }
    
    public var dateRange: DateRange {
        get {
            let defaultValue = DateRange.allTime
            guard let rawValue = string(forKey: PreferenceKey.dateRange.rawValue) else {
                return defaultValue
            }
            return DateRange(rawValue: rawValue) ?? defaultValue
        }
        set {
            set(newValue.rawValue, forKey: PreferenceKey.dateRange.rawValue)
            synchronize()
        }
    }
    
    public var statsGrouping: TransactionsGrouping {
        get {
            let defaultValue = TransactionsGrouping.month
            guard let rawValue = string(forKey: PreferenceKey.statsGrouping.rawValue) else {
                return defaultValue
            }
            return TransactionsGrouping(rawValue: rawValue) ?? defaultValue
        }
        set {
            set(newValue.rawValue, forKey: PreferenceKey.statsGrouping.rawValue)
            synchronize()
        }
    }
    
}
