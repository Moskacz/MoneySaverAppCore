//
//  ValueRepresenting.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.06.2018.
//

import Foundation

protocol ValueRepresenting {
    var valueRepresentation: NSDecimalNumber { get }
}

extension NSDecimalNumber: ValueRepresenting {
    var valueRepresentation: NSDecimalNumber {
        return self
    }
}
