//
//  SetupBudgetPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05/12/2018.
//

import Foundation

public protocol SetupBudgetPresenterProtocol: class {
    func closeViewClicked()
    func save(budget: String?)
}

public enum SetupBudgetError {
    case invalidAmount
}
