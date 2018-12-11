//
//  TransactionCategoriesPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoriesPresenterProtocol: class {
    func start()
    func categoriesLoaded(resultsController: ResultsController<TransactionCategoryProtocol>)
    func selectItem(at path: IndexPath)
    var numberOfCategories: Int { get }
    func categoryItem(at indexPath: IndexPath) -> TransactionCategoryItemProtocol
}

internal class TransactionCategoriesPresenter {
    
    private let interactor: TransactionCategoriesCollectionInteractorProtocol
    private let transactionData: TransactionData
    private var resultsController: ResultsController<TransactionCategoryProtocol>?
    
    weak var router: TransactionCategoriesListRouting?
    weak var view: TransactionCategoriesCollectionUIProtocol?
    
    internal init(interactor: TransactionCategoriesCollectionInteractorProtocol,
                  transactionData: TransactionData) {
        self.interactor = interactor
        self.transactionData = transactionData
    }
}

extension TransactionCategoriesPresenter: TransactionCategoriesPresenterProtocol {
    
    func start() {
        interactor.loadData()
    }
    
    func categoriesLoaded(resultsController: ResultsController<TransactionCategoryProtocol>) {
        self.resultsController = resultsController
        #warning("handle updates from frc")
        view?.reloadList()
    }
    
    func selectItem(at path: IndexPath) {
        let category = resultsController!.object(at: path)
        interactor.saveTransaction(data: transactionData, category: category)
        router?.flowEnded()
    }
    
    var numberOfCategories: Int {
        return resultsController?.objectsIn(section: 0)?.count ?? 0
    }
    
    func categoryItem(at indexPath: IndexPath) -> TransactionCategoryItemProtocol {
        let category = resultsController!.object(at: indexPath)
        return TransactionCategoryItem(category: category)
    }
}
