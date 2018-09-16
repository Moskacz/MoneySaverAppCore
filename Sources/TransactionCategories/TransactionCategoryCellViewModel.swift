//
//  TransactionCategoryCellViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 16.09.2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoryCellViewModel {
    var name: String? { get }
    var icon: Image? { get }
}
