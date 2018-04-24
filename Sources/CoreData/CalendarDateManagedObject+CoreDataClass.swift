//
//  CalendarDateManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData


public class CalendarDateManagedObject: NSManagedObject {

    public func update(with date: CalendarDate) {
        calendarIdentifier = date.calendarIdentifier
        dayOfEra = date.dayOfEra
        dayOfMonth = date.dayOfMonth
        dayOfYear = date.dayOfYear
        era = date.era
        weekOfEra = date.weekOfEra
        weekOfMonth = date.weekOfMonth
        weekOfYear = date.weekOfYear
        year = date.year
        timeInterval = date.timeInterval
        monthOfYear = date.monthOfYear
        monthOfEra = date.monthOfEra
    }
}

extension CalendarDateManagedObject: CalendarDateProtocol {}
