//
//  TransactionCellViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

public protocol TransactionCellViewModel {
    var titleText: String? { get }
    var descriptionText: String? { get }
    var categoryIcon: Image? { get }
    var dateText: String? { get }
    var indicatorGradient: Gradient? { get}
}
