//
//  TransactionsSummaryRouting.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06/12/2018.
//

import Foundation

public protocol TransactionsSummaryRoutingProtocol: class {
    func presentDateRangePicker(presenter: DateRangePickerPresenterProtocol)
}
