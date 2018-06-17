//
//  SegmentedControlTests_iOS.swift
//  MoneySaverAppCore-iOSTests
//
//  Created by Michal Moskala on 17.06.2018.
//

import XCTest
import UIKit
import MoneySaverAppCore

class SegmentedControlTests_iOS: XCTestCase {
    
    func test_getItems() {
        let segmentedControl = UISegmentedControl(items: ["raz", "dwa", "trzy"])
        let items = segmentedControl.items
        XCTAssertEqual(items[0], SegmentedControlItem.text("raz"))
        XCTAssertEqual(items[1], SegmentedControlItem.text("dwa"))
        XCTAssertEqual(items[2], SegmentedControlItem.text("trzy"))
    }
    
    func test_getItems_images() {
        let segmentedControl = UISegmentedControl(items: [UIImage(), UIImage()])
        let items = segmentedControl.items
        XCTAssertEqual(items.count, 2)
        XCTAssertNotNil(segmentedControl.imageForSegment(at: 0))
        XCTAssertNotNil(segmentedControl.imageForSegment(at: 1))
    }
    
    func test_setItems() {
        let segmentedControl = UISegmentedControl()
        segmentedControl.items = [SegmentedControlItem.text("raz"),
                                  SegmentedControlItem.text("dwa")]
        XCTAssertEqual(segmentedControl.titleForSegment(at: 0), "raz")
        XCTAssertEqual(segmentedControl.titleForSegment(at: 1), "dwa")
    }
    
    func test_setItems_images() {
        let segmentedControl = UISegmentedControl()
        segmentedControl.items = [SegmentedControlItem.image(UIImage()),
                                  SegmentedControlItem.image(UIImage())]
        XCTAssertNotNil(segmentedControl.imageForSegment(at: 0))
        XCTAssertNotNil(segmentedControl.imageForSegment(at: 1))
    }
}
