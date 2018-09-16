//
//  Error+Utils.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13.09.2018.
//

import Foundation

extension OptionSet {
    
    init(array: [Self.Element]) {
        self.init()
        for element in array {
            insert(element)
        }
    }
}
