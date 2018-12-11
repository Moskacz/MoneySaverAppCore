//
//  TransactionCategoriesCollectionInteractorTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 26/11/2018.
//

import XCTest
import MMFoundation
@testable import MoneySaverAppCore

class TransactionCategoriesCollectionInteractorTests: XCTestCase {

    private var categoriesRepository: FakeTransactionCategoryRepository!
    private var transactionsRepository: FakeTransactionsRepository!
    private var presenter: FakePresenter!
    private var sut: TransactionCategoriesCollectionInteractor!
    
    override func setUp() {
        categoriesRepository = FakeTransactionCategoryRepository()
        transactionsRepository = FakeTransactionsRepository()
        presenter = FakePresenter()
        sut = TransactionCategoriesCollectionInteractor(categoriesRepository: categoriesRepository,
                                                        transactionsRepository: transactionsRepository,
                                                        logger: NullLogger())
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        categoriesRepository = nil
        transactionsRepository = nil
        presenter = nil
    }

    func test_loadData_presenterShouldBeUpdatedWithListAdapter() {
        let categories = [FakeTransactionCategory(name: "a", image: nil),
                          FakeTransactionCategory(name: "b", image: nil)]
        
        categoriesRepository.resultsController = ResultsControllerFake(items: categories)
        sut.loadData()
        
        XCTAssertNotNil(presenter.resultsController)
        XCTAssertEqual(presenter.resultsController?.sectionsCount, 1)
        XCTAssertEqual(presenter.resultsController?.objectsIn(section: 0)?.count, 2)
        XCTAssertEqual(presenter.resultsController?.object(at: IndexPath(item: 0, section: 0)).name, "a")
        XCTAssertEqual(presenter.resultsController?.object(at: IndexPath(item: 1, section: 0)).name, "b")
    }

}

private class FakePresenter: TransactionCategoriesPresenterProtocol {
    
    var numberOfCategories: Int = 0
    
    func categoryItem(at indexPath: IndexPath) -> TransactionCategoryItemProtocol {
        fatalError()
    }
    
    var resultsController: ResultsController<TransactionCategoryProtocol>?
    func categoriesLoaded(resultsController: ResultsController<TransactionCategoryProtocol>) {
        self.resultsController = resultsController
    }
    
    func selectItem(at path: IndexPath) {}
    func start() {}
}
