//
//  TransactionCellDescriptor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

public final class TransactionCellDescriptor<TC: TransactionCell>: CellDescriptor {
    public typealias Cell = TC
    public typealias T = TransactionProtocol
    
    private let dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    public func configure(cell: TC, with object: TransactionProtocol) {
        let viewModel = TransactionCellViewModelImpl(transaction: object,
                                                     formatter: dateFormatter)
        cell.set(icon: viewModel.categoryIcon)
        cell.set(amount: viewModel.titleText)
        cell.set(title: viewModel.descriptionText)
        cell.set(date: viewModel.dateText)
        cell.set(indicator: viewModel.indicatorGradient)
    }
}
