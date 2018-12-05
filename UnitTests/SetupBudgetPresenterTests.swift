//
//  SetupBudgetPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05/12/2018.
//

import XCTest
@testable import MoneySaverAppCore

class SetupBudgetPresenterTests: XCTestCase {

    private var sut: SetupBudgetPresenter!
    private var interactor: FakeInteractor!
    private var userInterface: FakeUserInterface!
    private var router: FakeRouter!
    
    override func setUp() {
        interactor = FakeInteractor()
        userInterface = FakeUserInterface()
        router = FakeRouter()
        sut = SetupBudgetPresenter(interactor: interactor,
                                   userInterface: userInterface,
                                   router: router)
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        userInterface = nil
        router = nil
    }

    func test_saveBudget_whenNilBudgetIsPassed_thenErrorShouldBeShown(){
        sut.save(budget: nil)
        XCTAssertEqual(userInterface.error, SetupBudgetError.invalidAmount)
    }

    func test_saveBudget_whenEmptyBudgetIsPassed_thenErrorShouldBeShown() {
        sut.save(budget: "")
        XCTAssertEqual(userInterface.error, SetupBudgetError.invalidAmount)
    }
    
    func test_saveBudget_whenNonNumberValueIsPassed_thenErrorShouldBeShown() {
        sut.save(budget: "abc")
        XCTAssertEqual(userInterface.error, SetupBudgetError.invalidAmount)
    }
    
    func test_saveBudget_whenNegativeValueIsPassed_thenErrorShouldBeShown() {
        sut.save(budget: "-2000")
        XCTAssertEqual(userInterface.error, SetupBudgetError.invalidAmount)
    }
    
    func test_saveBudget_whenCorrectValueIsPassed_thenInteractorShouldBeCalled() {
        sut.save(budget: "2000")
        XCTAssertEqual(interactor.budget, Decimal(2000))
    }
    
    func test_saveBudget_afterSaveScreenShouldBeDismissed() {
        sut.save(budget: "2000")
        XCTAssertTrue(router.dismissCalled)
    }
}

private class FakeInteractor: SetupBudgetInteractorProtocol {
    
    var budget: Decimal?
    func save(budget: Decimal) {
        self.budget = budget
    }
}

private class FakeUserInterface: SetupBudgetUI {
    
    var error: SetupBudgetError?
    func display(error: SetupBudgetError) {
        self.error = error
    }
}

private class FakeRouter: BudgetRoutingProtocol {
    
    var dismissCalled = false
    func dismissBudgetAmountEditor() {
        dismissCalled = true
    }
    
    func presentBudgetAmountEditor() {}
}
