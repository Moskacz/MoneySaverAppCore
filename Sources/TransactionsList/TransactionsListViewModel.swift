//
//  TransactionsListViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListViewModel {
    func set(delegate: ResultsControllerDelegate)
    var numberOfSections: Int { get }
    func numberOfRowsIn(section: Int) -> Int
    func configure(cell: TransactionCell, at path: IndexPath)
    func titleFor(section: Int) -> String
    func commitDeletionOfTransactionAt(indexPath: IndexPath)
}
