//
//  FakeTransactionCategory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 12.06.2018.
//

import Foundation
import MoneySaverAppCore
@testable import MMFoundation

class FakeTransactionCategory: TransactionCategoryProtocol {
    var name: String? = nil
    var image: Image? = nil
}
