//
//  SetupBudgetUserInterface.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05/12/2018.
//

import Foundation

public protocol SetupBudgetUI: class {
    func display(error: SetupBudgetError)
}
