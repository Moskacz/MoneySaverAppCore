//
//  TransactionDataInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import Foundation

protocol TransactionDataInteractorProtocol {
    func transactionData(with title: String, amount: Decimal, date: Date) -> TransactionData
}

internal class TransactionDataInteractor {
    
    private let calendar: CalendarProtocol
    
    init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
}

extension TransactionDataInteractor: TransactionDataInteractorProtocol {
    
    func transactionData(with title: String, amount: Decimal, date: Date) -> TransactionData {
        return TransactionData(title: title, value: amount, date: calendar.calendarDate(from: date))
    }
}
