//
//  Color.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 26.04.2018.
//

import Foundation

#if os(OSX)
import AppKit
public typealias Color = NSColor
#elseif os(iOS)
import UIKit
public typealias Color = UIColor
#endif

extension Color {
    
}
