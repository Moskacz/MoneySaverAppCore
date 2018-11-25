//
//  TransactionCategoriesPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoriesPresenterProtocol: class {
    func itemLoaded(adapter: ListAdapter<TransactionCategoryItemProtocol>)
    func select(item: TransactionCategoryItemProtocol)
}
