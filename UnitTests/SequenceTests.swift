//
//  SequenceTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 30.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverAppCore


class SequenceTests: XCTestCase {
    
    func test_grouped() {
        let person1 = Person(name: "Jan", age: 30)
        let person2 = Person(name: "Pawel", age: 20)
        let person3 = Person(name: "Michal", age: 25)
        let person4 = Person(name: "Piotr", age: 25)
        let persons = [person1, person2, person3, person4]
        
        let grouped = persons.grouped { $0.age }
        XCTAssertEqual(grouped[30]!, [person1])
        XCTAssertEqual(grouped[20]!, [person2])
        XCTAssertEqual(grouped[25]!, [person3, person4])
    }
    
    func test_grouped_nilKey() {
        let person1 = Person(name: "Jan", age: 30)
        let person2 = Person(name: "Pawel", age: 30)
        let person3 = Person(name: "Michal", age: nil)
        
        let grouped = [person1, person2, person3].grouped { $0.age}
        XCTAssertEqual(grouped.keys.count, 1) // there is only one group for age 30
    }
    
    func test_valueRepresenting_sum() {
        let value1 = NSDecimalNumber(value: 2)
        let value2 = NSDecimalNumber(value: 4)
        let value3 = NSDecimalNumber(value: -10)
        let sum = [value1, value2, value3].sum
        XCTAssertEqual(sum.floatValue, -4, accuracy: 0.00001)
    }
    
    func test_compoundSum_shouldComputeSumForGivenDate() {
        let today = FakeCalendarDate()
        today.dayOfEra = 1
        today.weekOfEra = 2
        today.monthOfEra = 3
        today.year = 2018
        
        let todayTransaction = FakeTransaction()
        todayTransaction.transactionDate = today
        todayTransaction.value = NSDecimalNumber(value: 20)
        
        let yesterday = FakeCalendarDate()
        yesterday.dayOfEra = 0
        yesterday.weekOfEra = 2
        yesterday.monthOfEra = 3
        yesterday.year = 2018
        
        let yesterdayTransaction = FakeTransaction()
        yesterdayTransaction.transactionDate = yesterday
        yesterdayTransaction.value = NSDecimalNumber(value: 10)
        
        let compoundSum = [todayTransaction, yesterdayTransaction].compoundSum(date: today)
        XCTAssertEqual(compoundSum.daily.incomes, Decimal(20)) // only today
        XCTAssertEqual(compoundSum.weekly.incomes, Decimal(30)) // both
        XCTAssertEqual(compoundSum.monthly.incomes, Decimal(30)) // both
        XCTAssertEqual(compoundSum.yearly.incomes, Decimal(30)) // both
        XCTAssertEqual(compoundSum.era.incomes, Decimal(30)) // both
    }
    
    func test_transactionsSum() {
        let transaction1 = FakeTransaction()
        transaction1.value = NSDecimalNumber(value: 10)
        
        let transaction2 = FakeTransaction()
        transaction2.value = NSDecimalNumber(value: 20)
        
        let transaction3 = FakeTransaction()
        transaction3.value = NSDecimalNumber(value: -50)
        
        let sum = [transaction1, transaction2, transaction3].transactionsSum
        XCTAssertEqual(sum.incomes, Decimal(30))
        XCTAssertEqual(sum.expenses, Decimal(-50))
        XCTAssertEqual(sum.total(), Decimal(-20))
    }
    
}

private struct Person {
    let name: String
    let age: Int?
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}
