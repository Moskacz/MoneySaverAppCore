//
//  Sequence+Int.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13.06.2018.
//

import Foundation

extension Sequence where Element == Int {
    
    public var rangesOfMissingValues: [CountableClosedRange<Int>] {
        let sortedElements = sorted()
        var iterator = sortedElements.makeIterator()
        guard var value = iterator.next() else { return [] }
        
        var ranges = [CountableClosedRange<Int>]()
        
        while let nextValue = iterator.next() {
            if value.distance(to: nextValue) > 1 {
                let rangeStart = value + 1
                let rangeEnd = nextValue - 1
                let range = rangeStart...rangeEnd;
                ranges.append(range)
            }
            value = nextValue
        }
        
        return ranges
    }
    
}
