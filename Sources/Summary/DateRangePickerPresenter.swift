//
//  DateRangePickerPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09/12/2018.
//

import Foundation

public struct DateRangeItem {
    public let title: String
    public let range: DateRange
}

public protocol DateRangePickerPresenterProtocol {
    var items: [DateRangeItem] { get }
    func select(item: DateRangeItem)
}


