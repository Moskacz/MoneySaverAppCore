//
//  FakeTransactionCategoryRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.09.2018.
//

import Foundation
import MMFoundation
import MoneySaverAppCore

class FakeTransactionCategoryRepository: TransactionCategoryRepository {
    
    var resultsController: ResultsControllerFake<TransactionCategoryProtocol>!
    
    var allCategoriesResultController: ResultsController<TransactionCategoryProtocol> {
        get { return resultsController }
        set { fatalError() }
    }
    
    func addCategory(with data: TransactionCategoryData) {
        
    }
}
