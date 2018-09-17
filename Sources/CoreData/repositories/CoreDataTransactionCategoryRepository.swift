//
//  CoreDataTransactionCategoryRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17.09.2018.
//

import Foundation
import MMFoundation

internal class CoreDataTransactionCategoryRepository: TransactionCategoryRepository {
    
    var allCategoriesResultController: ResultsController<TransactionCategoryProtocol> {
        fatalError()
    }
}
