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
    func addCategory(with data: TransactionCategoryData)
}

public struct TransactionCategoryData {
    let name: String
    let image: Image
}
