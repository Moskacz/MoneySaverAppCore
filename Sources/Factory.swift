//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation

public class Factory {
    
    func transactionsSummaryPresenter() -> TransactionsSummaryPresenterProtocol {
        return TransactionsSummaryPresenter(interactor: transactionsSummaryInteractor())
    }
    
    private func transactionsSummaryInteractor() -> TransactionsSummaryInteractorProtocol {
        return TransactionsSummaryInteractor(repository: transactionsRepository,
                                             calendar: calendar,
                                             dateRange: DateRange.allTime)
    }
    
    func transactionsListPresenter() -> TransactionsListPresenterProtocol {
        fatalError()
    }
    
    func budgetPresenter() -> BudgetPresenterProtocol {
        fatalError()
    }
    
    func statsPresenter() -> StatsPresenterProtocol {
        fatalError()
    }
    
    func settingsPresenter() -> SettingsPresenterProtocol {
        fatalError()
    }
    
    private let coreDataStack: CoreDataStack = CoreDataStackImplementation()
    private let logger: Logger = NullLogger()
    private let calendar: CalendarProtocol = Calendar.current
    private let notificationCenter: TransactionNotificationCenter = NotificationCenter.default
    
    private lazy var transactionsRepository: TransactionsRepository = {
        return CoreDataTransactionsRepository(context: self.coreDataStack.getViewContext(),
                                              logger: self.logger,
                                              notificationCenter: self.notificationCenter)
    }()
}

