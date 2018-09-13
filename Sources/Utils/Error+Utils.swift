//
//  Error+Utils.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13.09.2018.
//

import Foundation

protocol CollectionOptionSetReducing {
    func reduce(options: [Self]) -> Self
}
