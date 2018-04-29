//
//  Logger.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 14.05.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

public enum LogLevel {
    case verbose
    case debug
    case info
    case warning
    case error
}

public protocol Logger {
    func log(withLevel level: LogLevel, message: @autoclosure () -> String)
}

public class NullLogger: Logger {
    public init() {}
    public func log(withLevel level: LogLevel, message: @autoclosure () -> String) {}
}
