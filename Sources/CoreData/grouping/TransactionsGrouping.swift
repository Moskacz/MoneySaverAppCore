//
//  TransactionsGrouping.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public enum TransactionsGrouping {
    case day
    case week
    case month
}

extension TransactionsGrouping: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .day: return "Day"
        case .week: return "Week"
        case .month: return "Month"
        }
    }
}
