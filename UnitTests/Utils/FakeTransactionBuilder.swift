//
//  FakeTransactionBuilder.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 12.06.2018.
//

import Foundation

class FakeTransactionBuilder {
    
    private var dayOfEra: Int32 = 0
    private var weekOfEra: Int32 = 0
    private var monthOfEra: Int32 = 0
    private var value = Decimal(0)
    private var categoryName: String?
    
    func set(dayOfEra: Int32) -> FakeTransactionBuilder {
        self.dayOfEra = dayOfEra
        return self
    }
    
    func set(weekOfEra: Int32) -> FakeTransactionBuilder {
        self.weekOfEra = weekOfEra
        return self
    }
    
    func set(monthOfEra: Int32) -> FakeTransactionBuilder {
        self.monthOfEra = monthOfEra
        return self
    }
    
    func set(value: Decimal) -> FakeTransactionBuilder {
        self.value = value
        return self
    }
    
    func set(categoryName: String?) -> FakeTransactionBuilder {
        self.categoryName = categoryName
        return self
    }
    
    func build() -> FakeTransaction {
        let transaction = FakeTransaction()
        transaction.value = value
        
        let date = FakeCalendarDate()
        date.dayOfEra = dayOfEra
        date.weekOfEra = weekOfEra
        date.monthOfEra = monthOfEra
        transaction.transactionDate = date
        
        let category = FakeTransactionCategory()
        category.name = categoryName
        transaction.transactionCategory = category
        
        return transaction
    }
}
