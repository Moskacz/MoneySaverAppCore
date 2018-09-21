//
//  TransactionCategoryProtocol.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 04.02.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import MMFoundation

public protocol TransactionCategoryProtocol: UniqueIdentifiable {
    var name: String? { get }
    var image: Image? { get }
}
