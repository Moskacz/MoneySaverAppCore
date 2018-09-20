//
//  SettingsViewCoordinatorImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.09.2018.
//

import Foundation

internal class SettingsViewCoordinatorImpl: SettingsViewCoordinator {
    
    private unowned let display: SettingsDisplaying
    private let flow: SettingsFlow
    
    let items: [SettingItem]
    
    internal init(display: SettingsDisplaying, flow: SettingsFlow) {
        self.display = display
        self.flow = flow
        self.items = [.manageCategories, .privacy, .contactUs, .licenses]
        display.reloadItems()
    }
    
    func choose(item: SettingItem) {
        flow.choose(item: item)
    }
    
}
