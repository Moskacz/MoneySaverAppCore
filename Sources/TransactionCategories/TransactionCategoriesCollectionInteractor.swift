//
//  TransactionCategoriesCollectionInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation

internal protocol TransactionCategoriesCollectionInteractorProtocol {
    func loadData()
}

internal class TransactionCategoriesCollectionInteractor {
    
    private let repository: TransactionCategoryRepository
    
    internal init(repository: TransactionCategoryRepository) {
        self.repository = repository
    }
}

extension TransactionCategoriesCollectionInteractor: TransactionCategoriesCollectionInteractorProtocol {
    
    func loadData() {
        
    }
}
