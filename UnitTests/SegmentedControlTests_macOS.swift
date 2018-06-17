//
//  SegmentedControlTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17.06.2018.
//

import XCTest
import AppKit
import MoneySaverAppCore

class SegmentedControlTests: XCTestCase {
    
    var sut: NSSegmentedControl!
    
    override func setUp() {
        super.setUp()
        sut = NSSegmentedControl(labels: ["a", "b", "c"], trackingMode: .selectOne, target: nil, action: nil)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_setItems() {
        sut.items = [SegmentedControlItem.text("label1"), SegmentedControlItem.text("label2")]
        XCTAssertEqual(sut.segmentCount, 2)
        XCTAssertEqual(sut.label(forSegment: 0), "label1")
        XCTAssertEqual(sut.label(forSegment: 1), "label2")
    }
    
    func test_getItems() {
        let items = sut.items
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[0], SegmentedControlItem.text("a"))
        XCTAssertEqual(items[1], SegmentedControlItem.text("b"))
        XCTAssertEqual(items[2], SegmentedControlItem.text("c"))
    }
    
}
