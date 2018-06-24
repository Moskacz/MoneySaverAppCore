//
//  TransactionNotificationCenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.06.2018.
//

import Foundation
@testable import MoneySaverAppCore

class FakeTransactionNotificationCenter: TransactionNotificationCenter {
    
    var postedNotification: TransactionNotification?
    
    func postTransactionsDidChange(notification: TransactionNotification) {
        postedNotification = notification
    }
    
    func observeTransactionsDidChange(callback: @escaping (TransactionNotification) -> Void) -> ObservationToken {
        fatalError()
    }
}
