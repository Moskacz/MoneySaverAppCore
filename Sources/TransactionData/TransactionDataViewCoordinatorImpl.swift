//
//  TransactionDataViewCoordinatorImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.09.2018.
//

import Foundation

internal class TransactionDataViewCoordinatorImpl: TransactionDataViewCoordinator {
    
    private let formatter: DateFormatter
    
    internal init(formatter: DateFormatter) {
        self.formatter = formatter
    }
    
    var display: TransactionDataDisplaying? {
        didSet {
           updateDisplay()
        }
    }
    
    func set(title: String?, value: String?, date: Date) {
        
    }
    
    private func updateDisplay() {
        display?.update(with: currentViewState)
    }
    
    private var currentViewState: ViewState {
        return ViewState(title: nil, amount: nil, date: formatter.string(from: Date()))
    }
}

private struct ViewState {
    let title: String?
    let amount: String?
    let date: String?
    
    static var empty: ViewState {
        return ViewState(title: nil, amount: nil, date: nil)
    }
}

private extension TransactionDataDisplaying {
    func update(with viewState: ViewState) {
        set(title: viewState.title)
        set(amount: viewState.amount)
        set(date: viewState.date)
    }
}
