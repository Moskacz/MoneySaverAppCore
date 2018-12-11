//
//  TransactionCategoryManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData
import MMFoundation

#if os(OSX)
import AppKit
#elseif os(iOS)
import UIKit
#endif

public class TransactionCategoryManagedObject: NSManagedObject {

    public enum KeyPaths {
        case name
        
        var string: String {
            return #keyPath(cd_name)
        }
    }
    
    public lazy var image: Image? = {
        guard let data = cd_icon else { return nil }
        return Image(data: data as Data)
    }()
}

extension TransactionCategoryManagedObject: TransactionCategoryProtocol {
    
    public var name: String? { return cd_name }
    public var identifier: UUID { return cd_identifier! }
}
