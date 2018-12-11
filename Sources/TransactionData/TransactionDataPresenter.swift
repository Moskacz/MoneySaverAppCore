//
//  TransactionDataPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionDataPresenterProtocol {
    var transactionTitle: String? { get set }
    var transactionAmount: String? { get set }
    var transactionDate: Date? { get set }
    func nextTapped()
    func cancelTapped()
}

public struct TransactionDataViewError: Error, OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let invalidValue = TransactionDataViewError(rawValue: 1)
    public static let missingValue = TransactionDataViewError(rawValue: 1 << 1)
    public static let missingTitle = TransactionDataViewError(rawValue: 1 << 2)
    public static let missingDate = TransactionDataViewError(rawValue: 1 << 3)
}

internal final class TransactionDataPresenter {
    
    var transactionTitle: String?
    var transactionAmount: String?
    var transactionDate: Date?
    weak var view: TransactionDataUI?
    
    private let interactor: TransactionDataInteractorProtocol
    private let routing: TransactionDataRouting
    
    init(interactor: TransactionDataInteractorProtocol, routing: TransactionDataRouting) {
        self.interactor = interactor
        self.routing = routing
    }
}

extension TransactionDataPresenter: TransactionDataPresenterProtocol {
    
    func nextTapped() {
        let title = validate(title: transactionTitle)
        let amount = validate(amount: transactionAmount)
        let date = validate(date: transactionDate)
        
        switch (title, amount, date) {
        case (.value(let title), .value(let amount), .value(let date)):
            let data = interactor.transactionData(with: title, amount: amount, date: date)
            routing.showTransactionCategoriesPicker(transactionData: data)
        case (let title, let amount, let date):
            let errors = [title.error, amount.error, date.error].compactMap { $0 }
            view?.display(error: TransactionDataViewError(array: errors))
        }
    }
    
    func cancelTapped() {
        routing.closeView()
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


