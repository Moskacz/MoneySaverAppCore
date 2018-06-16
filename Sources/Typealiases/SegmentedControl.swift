//
//  SegmentedControl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 16.06.2018.
//

import Foundation

public protocol SegmentedControlAdditions {
    var items: [SegmentedControlItem] { get set }
}

public enum SegmentedControlItem: Equatable {
    case text(String)
    case image(Image)
    
    public var value: Any {
        switch self {
        case .text(let val): return val
        case .image(let val): return val
        }
    }
}

#if os(iOS)
import UIKit
extension UISegmentedControl: SegmentedControlAdditions {
    
    public var items: [SegmentedControlItem] {
        set {
            removeAllSegments()
            for (index, item) in newValue.enumerated() {
                insert(item: item, at: index)
            }
        }
        get {
            let range = 0..<numberOfSegments
            return range.map { item(at: $0) }
        }
    }
    
    private func insert(item: SegmentedControlItem, at index: Int) {
        switch item {
        case .text(let value):
            insertSegment(withTitle: value, at: index, animated: false)
        case .image(let value):
            insertSegment(with: value, at: index, animated: false)
        }
    }
    
    private func item(at index: Int) -> SegmentedControlItem {
        if let title = titleForSegment(at: index) {
            return SegmentedControlItem.text(title)
        } else if let image = imageForSegment(at: index) {
            return SegmentedControlItem.image(image)
        } else {
            fatalError()
        }
    }
}
#endif
