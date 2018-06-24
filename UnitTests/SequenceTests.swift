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
    
    func test_transactions_sum() {
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(1)).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(2)).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(3)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        XCTAssertEqual(transactions.sum, 6)
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
        XCTAssertEqual(compoundSum.daily.incomes, 20) // only today
        XCTAssertEqual(compoundSum.weekly.incomes, 30) // both
        XCTAssertEqual(compoundSum.monthly.incomes, 30) // both
        XCTAssertEqual(compoundSum.yearly.incomes, 30) // both
        XCTAssertEqual(compoundSum.era.incomes, 30) // both
    }
    
    func test_transactionsSum() {
        let transaction1 = FakeTransaction()
        transaction1.value = NSDecimalNumber(value: 10)
        
        let transaction2 = FakeTransaction()
        transaction2.value = NSDecimalNumber(value: 20)
        
        let transaction3 = FakeTransaction()
        transaction3.value = NSDecimalNumber(value: -50)
        
        let sum = [transaction1, transaction2, transaction3].transactionsSum
        XCTAssertEqual(sum.incomes, 30)
        XCTAssertEqual(sum.expenses, -50)
        XCTAssertEqual(sum.total(), -20)
    }
    
    func test_expenses() {
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(-100)).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(200)).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(-50)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        let expenses = transactions.expenses
        XCTAssertEqual(expenses.count, 2)
        XCTAssertEqual(expenses[0].value, NSDecimalNumber(value: -100))
        XCTAssertEqual(expenses[1].value, NSDecimalNumber(value: -50))
    }
    
    func test_incomes() {
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(50)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        let incomes = transactions.incomes
        XCTAssertEqual(incomes.count, 2)
        XCTAssertEqual(incomes[0].value, NSDecimalNumber(value: 100))
        XCTAssertEqual(incomes[1].value, NSDecimalNumber(value: 50))
    }
    
    func test_sum() {
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(50)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        XCTAssertEqual(transactions.sum, -50)
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
