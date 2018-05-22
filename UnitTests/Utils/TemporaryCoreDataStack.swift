//
//  TemporaryCoreDataStackHandler.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.05.2018.
//

import Foundation
@testable import MoneySaverAppCore

final class TemporaryCoreDataStack: CoreDataStackImplementation {
    
    let temporaryURL: URL
    
    init() {
        self.temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("tmpDatabase.sqlite")
        super.init(storeURL: self.temporaryURL)
    }
    
    func cleanUp() {
        do {
            try FileManager.default.removeItem(at: temporaryURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    deinit {
        cleanUp()
    }
}
