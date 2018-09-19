//
//  TransactionDataViewCoordinatorImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.09.2018.
//

import Foundation
import MMFoundation

internal class TransactionDataViewCoordinatorImpl: TransactionDataViewCoordinator {
    
    private let formatter: DateFormatter
    private let flow: AddTransactionFlow
    
    internal init(formatter: DateFormatter, flow: AddTransactionFlow) {
        self.formatter = formatter
        self.flow = flow
    }
    
    var display: TransactionDataDisplaying? {
        didSet {
           updateDisplay()
        }
    }
    
    func set(title: String?, value: String?, date: Date?) {
        let title = validate(title: title)
        let amount = validate(amount: value)
        let date = validate(date: date)
        
        switch (title, amount, date) {
        case (.value(let title), .value(let amount), .value(let date)):
            let transactionData = TransactionData(title: title,
                                                  value: amount,
                                                  creationDate: date)
            flow.transactionData = transactionData
        case (let title, let amount, let date):
            let errors = [title.error, amount.error, date.error].compactMap { $0 }
            display?.display(error: TransactionDataViewError(array: errors))
        }
    }
    
    private func updateDisplay() {
        display?.update(with: currentViewState)
    }
    
    private var currentViewState: ViewState {
        return ViewState(title: nil, amount: nil, date: formatter.string(from: Date()))
    }
    
    // MARK: Validation
    
    private func validate(title: String?) -> Result<String, TransactionDataViewError> {
        guard let title = title, title.count > 0  else { return .error(.missingTitle) }
        return .value(title)
    }
    
    private func validate(amount: String?) -> Result<Decimal, TransactionDataViewError> {
        guard let amount = amount, amount.count > 0 else { return .error(.missingValue) }
        guard let decimal = Decimal(string: amount) else { return .error(.invalidValue) }
        if decimal.isNaN || decimal.isZero { return .error(.invalidValue) }
        return .value(decimal)
    }
    
    private func validate(date: Date?) -> Result<Date, TransactionDataViewError> {
        guard let date = date else { return .error(.missingDate) }
        return .value(date)
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
