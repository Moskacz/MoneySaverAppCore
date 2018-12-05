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

internal class SetupBudgetPresenter {
    
    private let interactor: SetupBudgetInteractorProtocol
    private unowned let userInterface: SetupBudgetUI
    private unowned let router: BudgetRoutingProtocol
    
    internal init(interactor: SetupBudgetInteractorProtocol,
                  userInterface: SetupBudgetUI,
                  router: BudgetRoutingProtocol) {
        self.interactor = interactor
        self.userInterface = userInterface
        self.router = router
    }
}

extension SetupBudgetPresenter: SetupBudgetPresenterProtocol {
    
    func closeViewClicked() {
        router.dismissBudgetAmountEditor()
    }
    
    func save(budget: String?) {
        guard let text = budget, !text.isEmpty, let value = Decimal(string: text), value > 0, !value.isNaN else {
            userInterface.display(error: .invalidAmount)
            return
        }
        
        interactor.save(budget: value)
        router.dismissBudgetAmountEditor()
    }
}
