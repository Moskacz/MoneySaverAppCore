//
//  TransactionCategoryCellViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 16.09.2018.
//

import Foundation
import MMFoundation

internal class TransactionCategoryCellViewModelImpl: TransactionCategoryCellViewModel {
    
    private let category: TransactionCategoryProtocol
    
    internal init(category: TransactionCategoryProtocol) {
        self.category = category
    }
    
    var name: String? {
        return category.name
    }
    
    var icon: Image? {
        return category.image
    }
}
