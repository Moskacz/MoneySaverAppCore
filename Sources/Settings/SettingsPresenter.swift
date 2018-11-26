//
//  SettingsRouter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 26/11/2018.
//

import Foundation

public protocol SettingsPresenterProtocol: class {
    func manageCategoriesTapped()
    func contactUsTapped()
    func yourPrivacyTapped()
    func licensesTapped()
}

internal class SettingsPresenter: SettingsPresenterProtocol {
    
    private let router: SettingsRoutingProtocol
    
    internal init(router: SettingsRoutingProtocol) {
        self.router = router
    }
    
    func manageCategoriesTapped() {
        router.showManageCategories()
    }
    
    func contactUsTapped() {
        router.showContactUsForm()
    }
    
    func yourPrivacyTapped() {
        router.showPrivacyDetails()
    }
    
    func licensesTapped() {
        router.showLicensesUsed()
    }
}
