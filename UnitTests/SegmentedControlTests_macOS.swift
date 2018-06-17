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
    
    func test_setItems() {
        let sut = NSSegmentedControl()
        sut.items = [SegmentedControlItem.text("label1"), SegmentedControlItem.text("label2")]
        XCTAssertEqual(sut.segmentCount, 2)
        XCTAssertEqual(sut.label(forSegment: 0), "label1")
        XCTAssertEqual(sut.label(forSegment: 1), "label2")
    }
    
    func test_setItems_images() {
        let sut = NSSegmentedControl()
        sut.items = [SegmentedControlItem.image(NSImage()), SegmentedControlItem.image(NSImage())]
        XCTAssertNotNil(sut.image(forSegment: 0))
        XCTAssertNotNil(sut.image(forSegment: 1))
    }
    
    func test_getItems() {
        let sut = NSSegmentedControl(labels: ["a", "b", "c"], trackingMode: .selectOne, target: nil, action: nil)
        let items = sut.items
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[0], SegmentedControlItem.text("a"))
        XCTAssertEqual(items[1], SegmentedControlItem.text("b"))
        XCTAssertEqual(items[2], SegmentedControlItem.text("c"))
    }
    
    func test_getItems_images() {
        let sut = NSSegmentedControl(images: [NSImage(), NSImage()], trackingMode: .selectOne, target: nil, action: nil)
        XCTAssertEqual(sut.items.count, 2)
    }
}
