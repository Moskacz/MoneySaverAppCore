//
//  ManagedObjectModel+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07.05.2018.
//

import Foundation
import CoreData

extension NSManagedObjectModel {
    
    internal static var defaultName: String {
        return "DataModel"
    }
    
    internal static func makeDefault() -> NSManagedObjectModel {
        let url = Bundle.local.url(forResource: defaultName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: url)!
    }
}
