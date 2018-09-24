//
//  Decimal+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/09/2018.
//

import Foundation

internal extension Decimal {
    
    var doubleValue: Double {
        return (self as NSDecimalNumber).doubleValue
    }
}
