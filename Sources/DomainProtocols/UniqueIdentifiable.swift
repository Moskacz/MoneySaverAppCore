//
//  UniqueIdentifiable.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21/09/2018.
//

import Foundation

public protocol UniqueIdentifiable {
    var identifier: UUID { get }
}
