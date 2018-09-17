//
//  TransactionCategoryRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17.09.2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoryRepository {
    var allCategoriesResultController: ResultsController<TransactionCategoryProtocol> { get }
}
