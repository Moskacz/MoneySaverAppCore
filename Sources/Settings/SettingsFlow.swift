//
//  SettingsFlow.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.09.2018.
//

import Foundation

public protocol SettingsFlow {
    func choose(item: SettingItem)
}