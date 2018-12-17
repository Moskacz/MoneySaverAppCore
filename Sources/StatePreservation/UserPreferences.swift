//
//  UserPreferences.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public protocol UserPreferences: class {
    var initialDataInsertDone: Bool { get set }
    var dateRange: DateRange? { get set }
    var statsGrouping: TransactionsGrouping? { get set }
    
    func observeDateRangeChange(handler: @escaping (DateRange?) -> Void)
}

extension UserDefaults: UserPreferences {
    
    private enum PreferenceKey: String {
        case initialDataInsert = "userPreferences_initialDataInsert"
        case dateRange = "userPreferences_dateRange"
        case statsGrouping = "userPreferences_statsGrouping"
    }
    
    public var initialDataInsertDone: Bool {
        get {
            return bool(forKey: PreferenceKey.initialDataInsert.rawValue)
        }
        set {
            set(newValue, forKey: PreferenceKey.initialDataInsert.rawValue)
            synchronize()
        }
    }

    
    public var dateRange: DateRange? {
        get {
            guard let rawValue = string(forKey: PreferenceKey.dateRange.rawValue) else {
                return nil
            }
            return DateRange(rawValue: rawValue)
        }
        set {
            set(newValue?.rawValue, forKey: PreferenceKey.dateRange.rawValue)
            synchronize()
        }
    }
    
    public var statsGrouping: TransactionsGrouping? {
        get {
            guard let rawValue = string(forKey: PreferenceKey.statsGrouping.rawValue) else {
                return nil
            }
            return TransactionsGrouping(rawValue: rawValue)
        }
        set {
            set(newValue?.rawValue, forKey: PreferenceKey.statsGrouping.rawValue)
            synchronize()
        }
    }
    
    public func observeDateRangeChange(handler: @escaping (DateRange?) -> Void) {
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { note in
            handler(self.dateRange)
        }
    }
}
