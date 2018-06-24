//
//  ChartsDataProcessor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07.06.2018.
//

import Foundation

public class ChartsDataProcessor {
    
    internal let calendar: CalendarProtocol
    
    public init(calendar: CalendarProtocol) {
        self.calendar = calendar
    }
}

public struct PlotValue {
    public let x: Int
    public let y: Double
}
