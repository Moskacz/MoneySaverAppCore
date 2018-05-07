//
//  Bundle+Extension.swift
//  MoneySaverAppCore-iOS
//
//  Created by Michal Moskala on 07.05.2018.
//

import Foundation

extension Bundle {
    
    private var local: Bundle {
        return Bundle(identifier: "michal.moskala.MoneySaverAppCore")!
    }
    
    var managedObjectModelURL: URL {
        return local.url(forResource: "DataModel", withExtension: "momd")!
    }
}
