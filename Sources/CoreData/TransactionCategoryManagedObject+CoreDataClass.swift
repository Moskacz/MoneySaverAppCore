//
//  TransactionCategoryManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData

#if os(OSX)
import AppKit
#elseif os(iOS)
import UIKit
#endif

public class TransactionCategoryManagedObject: NSManagedObject {

    enum AttributesNames: String {
        case name
    }
    
    enum SortDescriptors {
        case name
        
        var descriptor: NSSortDescriptor {
            return NSSortDescriptor(key: AttributesNames.name.rawValue, ascending: true)
        }
    }
    
    public lazy var image: Image? = {
        guard let data = icon else { return nil }
        return Image(data: data as Data)
    }()
}

extension TransactionCategoryManagedObject: TransactionCategoryProtocol {}
