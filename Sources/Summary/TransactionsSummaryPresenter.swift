//
//  TransactionsSummaryCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.09.2018.
//

import Foundation

public protocol TransactionsSummaryPresenterProtocol: class {
    func start()
    var dateRange: DateRange { get set }
    func stateComputed(_ state: TransactionsSummaryUIState)
}

public struct TransactionsSummaryUIState {
    let totalAmountText: String
    let expensesAmountText: String
    let incomesAmountText: String
    let dateRangeButtonText: String
}

internal class TransactionsSummaryPresenter: TransactionsSummaryPresenterProtocol {
 
    weak var display: TransactionsSummaryUI?
    
    private let interactor: TransactionsSummaryInteractorProtocol
    
    internal init(interactor: TransactionsSummaryInteractorProtocol) {
        self.interactor = interactor
    }
    
    func start() {
        interactor.computeSummary()
    }
    
    var dateRange: DateRange {
        get { return interactor.dateRange }
        set { interactor.dateRange = newValue }
    }
    
    func stateComputed(_ state: TransactionsSummaryUIState) {
        display?.set(totalAmountString: state.totalAmountText)
        display?.set(incomesText: state.incomesAmountText)
        display?.set(expenseText: state.expensesAmountText)
        display?.set(dateRangeTitle: state.dateRangeButtonText)
    }
}








