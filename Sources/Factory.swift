//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

public class Factory {
    
    public static var databaseURL: URL!
    
    public static func transactionsSummaryPresenter(display: TransactionsSummaryUI,
                                                    router: TransactionsSummaryRoutingProtocol) -> TransactionsSummaryPresenterProtocol {
        let interactor = TransactionsSummaryInteractor(repository: transactionsRepository,
                                                       calendar: calendar,
                                                       userPrefs: userPrefs)
        let presenter = TransactionsSummaryPresenter(interactor: interactor,
                                                     dateRangesInteractor: DateRangePickerInteractor(calendar: calendar),
                                                     router: router)
        presenter.display = display
        interactor.presenter = presenter
        return presenter
    }
    
    public static func transactionsListPresenter(display: TransactionsListUI & ResultsControllerDelegate) -> TransactionsListPresenterProtocol {
        let interactor = TransactionsListInteractor(repository: transactionsRepository,
                                                    logger: logger)
        let presenter = TransactionsListPresenter(display: display, interactor: interactor)
        interactor.presenter = presenter
        return presenter
    }
    
    public static func budgetPresenter(routing: BudgetRoutingProtocol, userInterface: BudgetUIProtocol) -> BudgetPresenterProtocol {
        let interactor = BudgetInteractor(budgetRepository: budgetRepository,
                                          transactionsRepository: transactionsRepository,
                                          calendar: calendar)
        let presenter = BudgetPresenter(interactor: interactor,
                                        routing: routing,
                                        chartsDataProcessor: chartsDataProcessor)
        interactor.presenter = presenter
        presenter.view = userInterface
        return presenter
    }
    
    public static func setupBudgetPresenter(routing: BudgetRoutingProtocol, userInterface: SetupBudgetUI) -> SetupBudgetPresenterProtocol {
        let interactor = SetupBudgetInteractor(repository: budgetRepository)
        let presenter = SetupBudgetPresenter(interactor: interactor, userInterface: userInterface, router: routing)
        return presenter
    }
    
    public static func transactionDataPresenter(userInterface: TransactionDataUI, router: TransactionDataRouting) -> TransactionDataPresenterProtocol {
        let interactor = TransactionDataInteractor(calendar: calendar)
        let presenter = TransactionDataPresenter(interactor: interactor, routing: router)
        presenter.view = userInterface
        return presenter
    }
    
    public static func categoriesListPresenter(transactionData: TransactionData,
                                               userInterface: TransactionCategoriesCollectionUIProtocol,
                                               router: TransactionCategoriesListRouting) -> TransactionCategoriesPresenterProtocol {
        let interactor = TransactionCategoriesCollectionInteractor(categoriesRepository: categoriesRepository,
                                                                   transactionsRepository: transactionsRepository,
                                                                   logger: logger)
        let presenter = TransactionCategoriesPresenter(interactor: interactor, transactionData: transactionData)
        presenter.view = userInterface
        presenter.router = router
        
        interactor.presenter = presenter
        return presenter
    }
    
    public static func statsPresenter(userInterface: StatsUIProtocol) -> StatsPresenterProtocol {
        let interactor = StatsInteractor(repository: transactionsRepository, userPreferences: userPrefs)
        let presenter = StatsPresenter(interactor: interactor, chartsDataProcessor: chartsDataProcessor)
        presenter.view = userInterface
        interactor.presenter = presenter
        return presenter
    }
    
    public func settingsPresenter(router: SettingsRoutingProtocol) -> SettingsPresenterProtocol {
        return SettingsPresenter(router: router)
    }
    
    private static let coreDataStack: CoreDataStack = CoreDataStackImplementation(databaseURL: databaseURL)
    private static let logger: Logger = NullLogger()
    private static let calendar: CalendarProtocol = Calendar.current
    private static let notificationCenter: TransactionNotificationCenter & AppEventsNotificationCenter = NotificationCenter.default
    private static let userPrefs: UserPreferences = UserDefaults.standard
    
    private static var transactionsRepository: TransactionsRepository = {
        return CoreDataTransactionsRepository(context: Factory.coreDataStack.getViewContext(),
                                              logger: Factory.logger,
                                              notificationCenter: Factory.notificationCenter,
                                              calendar: Factory.calendar)
    }()
    
    private static var categoriesRepository: TransactionCategoryRepository = {
        return CoreDataTransactionCategoryRepository(context: Factory.coreDataStack.getViewContext(),
                                                     userPrefs: userPrefs)
    }()
    
    private static var budgetRepository: BudgetRepository = {
       return BudgetRepositoryImpl(context: Factory.coreDataStack.getViewContext(),
                                   logger: Factory.logger)
    }()
    
    private static var chartsDataProcessor: BudgetChartsDataProcessor & StatsChartsDataProcessor = {
        return ChartsDataProcessor(calendar: Factory.calendar)
    }()
}

