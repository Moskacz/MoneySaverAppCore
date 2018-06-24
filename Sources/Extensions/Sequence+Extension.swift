//
//  Sequence+Extension.swift
//  MoneySaverApp-iOS
//
//  Created by Michal Moskala on 30.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public struct TransactionsSum {
    public let incomes: Decimal
    public let expenses: Decimal
    
    public func total() -> Decimal {
        return incomes + expenses
    }
    
    public static var zero: TransactionsSum {
        return TransactionsSum(incomes: 0, expenses: 0)
    }
}

public struct TransactionsCompoundSum {
    public let daily: TransactionsSum
    public let weekly: TransactionsSum
    public let monthly: TransactionsSum
    public let yearly: TransactionsSum
    public let era: TransactionsSum
}

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
    
    public func compoundSum(date: CalendarDateProtocol) -> TransactionsCompoundSum {
        var day = [Element]()
        var week = [Element]()
        var month = [Element]()
        var year = [Element]()
        
        for element in self {
            if element.transactionDate?.dayOfEra == date.dayOfEra {
                day.append(element)
            }
            if element.transactionDate?.weekOfEra == date.weekOfEra {
                week.append(element)
            }
            if element.transactionDate?.monthOfEra == date.monthOfEra {
                month.append(element)
            }
            if element.transactionDate?.year == date.year {
                year.append(element)
            }
        }
        
        return TransactionsCompoundSum(daily: day.transactionsSum,
                                       weekly: week.transactionsSum,
                                       monthly: month.transactionsSum,
                                       yearly: year.transactionsSum,
                                       era: self.transactionsSum)
    }
    
    public var transactionsSum: TransactionsSum {
        return TransactionsSum(incomes: incomes.sum, expenses: expenses.sum)
    }
    
    var incomes: [Element] {
        return self.filter { ($0.value ?? 0).doubleValue >= 0 }
    }
    
    var expenses: [Element] {
        return self.filter { ($0.value ?? 0).doubleValue < 0 }
    }
    
    var sum: Decimal {
        let sum = reduce(0) { (result, element) -> Double in
            return result + (element.value?.doubleValue ?? 0)
        }
        return Decimal(sum)
    }
}
