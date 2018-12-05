//
//  BudgetPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22/11/2018.
//

import XCTest
import Charts
@testable import MoneySaverAppCore

class BudgetPresenterTests: XCTestCase {

    private var sut: BudgetPresenter!
    
    override func setUp() {
        sut = BudgetPresenter(interactor: FakeInteractor(),
                              routing: FakeRouting(),
                              chartsDataProcessor: FakeChartsDataProcessor())
    }

    override func tearDown() {
        sut = nil
    }

    func test_whenDataUpdated_thenUIShouldBeUpdated() {
        let view = FakeUI()
        sut.view = view
        sut.dataUpdated(budget: FakeBudget(budgetValue: 100),
                        expenses: [])
        XCTAssertNotNil(view.combinedData)
        XCTAssertNotNil(view.pieChartData)
    }
    
    func test_pieChartCalculation() {
        let view = FakeUI()
        sut.view = view
        sut.dataUpdated(budget: FakeBudget(budgetValue: 100),
                        expenses: [FakeTransactionBuilder().set(value: -10).build(),
                                   FakeTransactionBuilder().set(value: -22).build()])
        
        XCTAssertEqual(view.pieChartData?.dataSets[0].entryForIndex(0)?.y, 32) // expenses 10 + 22
        XCTAssertEqual(view.pieChartData?.dataSets[0].entryForIndex(1)?.y, 68) // left 100 - 32
    }

}

private class FakeUI: BudgetUIProtocol {
    func showBudgetNotSetup() {}
    
    var pieChartData: PieChartData?
    func showBudgetPieChart(with data: PieChartData) {
        pieChartData = data
    }
    
    var combinedData: CombinedChartData?
    func showSpendingsChart(with data: CombinedChartData) {
        combinedData = data
    }
}

private class FakeInteractor: BudgetInteractorProtocol {
    func loadData() {}
    func saveBudget(amount: Decimal) {}
}

private class FakeRouting: BudgetRoutingProtocol {
    func presentBudgetAmountEditor() {}
    func dismissBudgetAmountEditor() {}
}

