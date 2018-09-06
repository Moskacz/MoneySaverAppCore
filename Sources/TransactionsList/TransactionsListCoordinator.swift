//
//  TransactionsListCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

public struct ListItemIndex{
    public let row: Int
    public let section: Int
    
    public init(row: Int, section: Int) {
        self.row = row
        self.section = section
    }
}

public protocol TransactionsListCoordinator {
    func set(delegate: ResultsControllerDelegate)
    var numberOfSections: Int { get }
    func numberOfRowsIn(section: Int) -> Int
    func cellViewModelAt(index: ListItemIndex) -> TransactionCellViewModel
    func titleFor(section: Int) -> String
    func commitDeletionOfTransactionAt(indexPath: IndexPath)
}
