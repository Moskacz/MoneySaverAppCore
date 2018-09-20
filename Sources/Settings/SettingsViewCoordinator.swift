//
//  SettingsCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.09.2018.
//

import Foundation

public protocol SettingsViewCoordinator {
    var items: [SettingItem] { get }
    func choose(item: SettingItem)
}

public enum SettingItem {
    case manageCategories
    case contactUs
    case privacy
    case licenses
}
