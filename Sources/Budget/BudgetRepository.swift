//
//  File.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 04.07.2018.
//

import Foundation

public protocol BudgetRepository {
    func saveBudget(withValue value: Decimal)
    func observeBudgetChanged(completion: @escaping ((BudgetProtocol) -> Void)) -> ObservationToken
}
