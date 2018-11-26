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

    private var repository: FakeTransactionCategoryRepository!
    private var presenter: FakePresenter!
    private var sut: TransactionCategoriesCollectionInteractor!
    
    override func setUp() {
        repository = FakeTransactionCategoryRepository()
        presenter = FakePresenter()
        sut = TransactionCategoriesCollectionInteractor(repository: repository,
                                                        logger: NullLogger())
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        repository = nil
        presenter = nil
    }

    func test_loadData_presenterShouldBeUpdatedWithListAdapter() {
        let categories = [FakeTransactionCategory(name: "a", image: nil),
                          FakeTransactionCategory(name: "b", image: nil)]
        
        repository.resultsController = ResultsControllerFake(items: categories)
        sut.loadData()
        
        XCTAssertNotNil(presenter.adapter)
        XCTAssertEqual(presenter.adapter?.numberOfSections, 1)
        XCTAssertEqual(presenter.adapter?.numberOfRows(in: 0), 2)
        XCTAssertEqual(presenter.adapter?.item(at: IndexPath(item: 0, section: 0)).name, "a")
        XCTAssertEqual(presenter.adapter?.item(at: IndexPath(item: 1, section: 0)).name, "b")
    }

}

private class FakePresenter: TransactionCategoriesPresenterProtocol {
    
    var adapter: ListAdapter<TransactionCategoryItemProtocol>?
    func itemsLoaded(adapter: ListAdapter<TransactionCategoryItemProtocol>) {
        self.adapter = adapter
    }
    
    func selectItem(at path: IndexPath) {}
    func start() {}
}
