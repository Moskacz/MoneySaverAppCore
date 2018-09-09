//
//  Sequence+Extension.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 30.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

extension Sequence {
    
    public func grouped<U: Hashable>(by key: (Element) -> U?) -> [U: [Element]] {
        var dict = [U: [Element]]()
        for element in self {
            guard let key = key(element) else { continue }
            var array = dict[key] ?? []
            array.append(element)
            dict[key] = array
        }
        return dict
    }
}

extension Sequence where Element == TransactionProtocol {
        
    internal var incomes: [Element] {
        return self.filter { ($0.value ?? 0).doubleValue >= 0 }
    }
    
    internal var expenses: [Element] {
        return self.filter { ($0.value ?? 0).doubleValue < 0 }
    }
    
    internal var sum: Double {
        return reduce(0) { (result, element) -> Double in
            return result + (element.value?.doubleValue ?? 0)
        }
    }
    
    internal func with(monthOfEra: Int32) -> [Element] {
        return filter {
            guard let transactionMonthOfEra = $0.transactionDate?.monthOfEra else { return false }
            return transactionMonthOfEra == monthOfEra
        }
    }
}
