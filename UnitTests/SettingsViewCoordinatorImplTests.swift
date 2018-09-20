//
//  SettingsViewCoordinatorImplTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.09.2018.
//

import XCTest
@testable import MoneySaverAppCore

class SettingsViewCoordinatorImplTests: XCTestCase {
    
    private var display: DisplayingFake!
    private var flow: FlowFake!
    private var sut: SettingsViewCoordinatorImpl!
    
    override func setUp() {
        super.setUp()
        display = DisplayingFake()
        flow = FlowFake()
        sut = SettingsViewCoordinatorImpl(display: display, flow: flow)
    }
    
    override func tearDown() {
        sut = nil
        display = nil
        flow = nil
        super.tearDown()
    }
    
    func test_chooseItem_shouldCallMethodOnFlow() {
        sut.choose(item: .licenses)
        XCTAssertEqual(flow.selectedItem, .licenses)
    }
    
    func test_items() {
        XCTAssertEqual(sut.items, [.manageCategories, .privacy, .contactUs, .licenses])
    }
    
    func test_afterInit_reloadShouldBeCalled() {
        XCTAssertTrue(display.reloadCalled)
    }
    
}

private class DisplayingFake: SettingsDisplaying {
    var reloadCalled = false
    
    func reloadItems() {
        reloadCalled = true
    }
}

private class FlowFake: SettingsFlow {
    var selectedItem: SettingItem?
    
    func choose(item: SettingItem) {
        selectedItem = item
    }
}
