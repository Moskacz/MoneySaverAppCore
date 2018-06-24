//
//  NSManagedObjectContext+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.06.2018.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func save(with logger: Logger?) {
        guard hasChanges else { return }
        do {
            try save()
        } catch {
            logger?.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}
