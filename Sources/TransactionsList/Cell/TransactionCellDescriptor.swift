//
//  TransactionCellDescriptor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

internal class TransactionCellDescriptor: CellDescriptor {
    typealias Cell = TransactionCell
    typealias T = TransactionProtocol
    
    private let dateFormatter: DateFormatter
    
    internal init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    func configure(cell: TransactionCell, with object: TransactionProtocol) {
        let viewModel = TransactionCellViewModelImpl(transaction: object,
                                                     formatter: dateFormatter)
        cell.set(icon: viewModel.categoryIcon)
        cell.set(amount: viewModel.titleText)
        cell.set(title: viewModel.descriptionText)
        cell.set(date: viewModel.dateText)
        cell.set(indicator: viewModel.indicatorGradient)
    }
}
