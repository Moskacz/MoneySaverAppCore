//
//  TransactionCategoryCollectionCoordinatorImplTest.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.09.2018.
//

import XCTest
import MMFoundation
@testable import MoneySaverAppCore

class TransactionCategoryCollectionCoordinatorImplTests: XCTestCase {
    
    private var repository: FakeTransactionCategoryRepository!
    
    override func setUp() {
        super.setUp()
        repository = FakeTransactionCategoryRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func test_categoriesCount() {
        let categories = [FakeTransactionCategory(), FakeTransactionCategory()]
        repository.resultsController = ResultsControllerFake(items: categories)
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository)
        
        XCTAssertEqual(sut.numberOfCategories, categories.count)
    }
    
    func test_viewModelAtPath() {
        let categories = [FakeTransactionCategory()]
        repository.resultsController = ResultsControllerFake(items: categories)
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository)
        
        // just check if there is no crash
        _ = sut.categoryViewModel(at: IndexPath(item: 0, section: 0))
    }
    
    func test_afterDataLoad_displayShouldBeReloaded() {
        repository.resultsController = ResultsControllerFake<TransactionCategoryProtocol>(items: [])
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository)
        let display = DisplayFake()
        sut.display = display
        XCTAssertTrue(display.didChangeContentCalled)
    }
}

private class DisplayFake: TransactionCategoryCollectionDisplaying {
    var didChangeContentCalled = false
    
    func resultsControllerDidChangeContent() {
        didChangeContentCalled = true
    }
    
    func resultsControllerWillChangeContent() {
        // no-op
    }
    
    func resultsControllerDid(change: ResultChangeType) {
        // no-op
    }
}
