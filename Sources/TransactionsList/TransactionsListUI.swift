//
//  TransactionsListUI.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListUI: class {
    var presenter: TransactionsListPresenterProtocol { get set }
    func displayList(with adapter: ListAdapter<TransactionCellItemProtocol>)
    func displayNoData()
}
