//
//  TransactionCell.swift
//  MoneySaverAppCore-iOS
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation
import MMFoundation

public protocol TransactionCell {
    func set(icon: Image?)
    func set(title: String?)
    func set(description: String?)
    func set(date: String?)
    func set(indicator: Gradient?)
}
