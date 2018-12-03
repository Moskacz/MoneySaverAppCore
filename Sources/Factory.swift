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
        let interactor = transactionsSummaryInteractor()
        let presenter = TransactionsSummaryPresenter(interactor: interactor)
        interactor.presenter = presenter
        return presenter
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
    
    public func budgetPresenter(routing: BudgetRoutingProtocol, userInterface: BudgetUIProtocol) -> BudgetPresenterProtocol {
        let interactor = budgetInteractor()
        let presenter = BudgetPresenter(interactor: interactor,
                                        routing: routing,
                                        chartsDataProcessor: chartsDataProcessor)
        interactor.presenter = presenter
        presenter.view = userInterface
        return presenter
    }
    
    private func budgetInteractor() -> BudgetInteractor {
        return BudgetInteractor(budgetRepository: budgetRepository,
                                transactionsRepository: transactionsRepository,
                                calendar: calendar)
    }
    
    func statsPresenter(userInterface: StatsUIProtocol) -> StatsPresenterProtocol {
        let interactor = statsInteractor()
        let presenter = StatsPresenter(interactor: interactor, chartsDataProcessor: chartsDataProcessor)
        presenter.view = userInterface
        interactor.presenter = presenter
        return presenter
    }
    
    private func statsInteractor() -> StatsInteractor {
        return StatsInteractor(repository: transactionsRepository, userPreferences: userPrefs)
    }
    
    func settingsPresenter(router: SettingsRoutingProtocol) -> SettingsPresenterProtocol {
        return SettingsPresenter(router: router)
    }
    
    private let coreDataStack: CoreDataStack = CoreDataStackImplementation()
    private let logger: Logger = NullLogger()
    private let calendar: CalendarProtocol = Calendar.current
    private let notificationCenter: TransactionNotificationCenter = NotificationCenter.default
    private let userPrefs: UserPreferences = UserDefaults.standard
    
    private lazy var transactionsRepository: TransactionsRepository = {
        return CoreDataTransactionsRepository(context: self.coreDataStack.getViewContext(),
                                              logger: self.logger,
                                              notificationCenter: self.notificationCenter)
    }()
    
    private lazy var budgetRepository: BudgetRepository = {
       return BudgetRepositoryImpl(context: self.coreDataStack.getViewContext(),
                                   logger: self.logger)
    }()
    
    private lazy var chartsDataProcessor: BudgetChartsDataProcessor & StatsChartsDataProcessor = {
        return ChartsDataProcessor(calendar: self.calendar)
    }()
}

