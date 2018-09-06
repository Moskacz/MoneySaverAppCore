//
//  TransactionCell.swift
//  MoneySaverAppCore-iOS
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

public protocol TransactionCell {
    func set(icon: Image?)
    func set(amount: String?)
    func set(title: String?)
    func set(date: String?)
    func set(indicator: Gradient?)
}

extension TransactionCell {
    
    func updateWith(viewModel: TransactionCellViewModel) {
        set(icon: viewModel.categoryIcon)
        set(amount: viewModel.titleText)
        set(title: viewModel.descriptionText)
        set(date: viewModel.dateText)
        set(indicator: viewModel.indicatorGradient)
    }
}
