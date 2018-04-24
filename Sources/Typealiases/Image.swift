//
//  Image.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.04.2018.
//

import Foundation

#if os(OSX)
import AppKit
public typealias Image = NSImage
#elseif os(iOS)
import UIKit
public typealias Image = UIImage
#endif
