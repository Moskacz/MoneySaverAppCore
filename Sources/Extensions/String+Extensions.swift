//
//  String+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.04.2018.
//

import Foundation

public extension String {
    
    public var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst().lowercased()
    }
}
