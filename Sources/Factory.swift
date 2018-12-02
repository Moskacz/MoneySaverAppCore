//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

public class Factory {
    
    public func transactionsSummaryPresenter() -> TransactionsSummaryPresenterProtocol {
        return TransactionsSummaryPresenter(interactor: transactionsSummaryInteractor())
    }
    
    private func transactionsSummaryInteractor() -> TransactionsSummaryInteractorProtocol {
        return TransactionsSummaryInteractor(repository: transactionsRepository,
                                             calendar: calendar,
                                             dateRange: DateRange.allTime)
    }
    
    public func transactionsListPresenter(display: TransactionsListUI & ResultsControllerDelegate) -> TransactionsListPresenterProtocol {
        let interactor = transactionsListInteractor()
        let presenter = TransactionsListPresenter(display: display, interactor: interactor)
        interactor.presenter = presenter
        return presenter
    }
    
    private func transactionsListInteractor() -> TransactionsListInteractor {
        return TransactionsListInteractor(repository: transactionsRepository,
                                          logger: logger)
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

