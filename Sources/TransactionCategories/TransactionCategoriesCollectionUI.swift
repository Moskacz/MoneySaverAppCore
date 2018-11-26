//
//  TransactionCategoriesCollectionView.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 26/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoriesCollectionUIProtocol: class {
    func displayList(with adataper: ListAdapter<TransactionCategoryItemProtocol>)
}
