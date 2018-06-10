//
//  TransactionsGrouping.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 15.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public enum TransactionsGrouping: String {
    case dayOfEra
    case weekOfEra
    case monthOfEra
}

extension TransactionsGrouping: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .dayOfEra: return "Day"
        case .weekOfEra: return "Week"
        case .monthOfEra: return "Month"
        }
    }
}
