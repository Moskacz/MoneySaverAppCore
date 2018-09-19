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
    private var flow: FlowFake!
    
    override func setUp() {
        super.setUp()
        flow = FlowFake()
        repository = FakeTransactionCategoryRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func test_categoriesCount() {
        let categories = [FakeTransactionCategory(), FakeTransactionCategory()]
        repository.resultsController = ResultsControllerFake(items: categories)
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository, flow: flow)
        
        XCTAssertEqual(sut.numberOfCategories, categories.count)
    }
    
    func test_viewModelAtPath() {
        let categories = [FakeTransactionCategory()]
        repository.resultsController = ResultsControllerFake(items: categories)
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository, flow: flow)
        
        // just check if there is no crash
        _ = sut.categoryViewModel(at: IndexPath(item: 0, section: 0))
    }
    
    func test_afterDataLoad_displayShouldBeReloaded() {
        repository.resultsController = ResultsControllerFake<TransactionCategoryProtocol>(items: [])
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository, flow: flow)
        let display = DisplayFake()
        sut.display = display
        XCTAssertTrue(display.didChangeContentCalled)
    }
    
    func test_chooseCategoryAtIndexPath_shouldSetCategoryAtFlow() {
        let categories = [FakeTransactionCategory(name: "some_name")]
        repository.resultsController = ResultsControllerFake(items: categories)
        let sut = TransactionCategoryCollectionCoordinatorImpl(repository: repository, flow: flow)
        
        sut.chooseCategory(at: IndexPath(item: 0, section: 0))
        XCTAssertEqual(categories.first?.name, flow.category?.name)
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

private class FlowFake: TransactionCategoryCollectionFlow {
    var category: TransactionCategoryProtocol?
}
