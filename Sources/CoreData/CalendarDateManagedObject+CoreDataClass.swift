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

    public func update(with date: CalendarDateProtocol) {
        cd_calendarIdentifier = date.calendarIdentifier
        cd_dayOfEra = date.dayOfEra
        cd_dayOfMonth = date.dayOfMonth
        cd_dayOfYear = date.dayOfYear
        cd_era = date.era
        cd_weekOfEra = date.weekOfEra
        cd_weekOfMonth = date.weekOfMonth
        cd_weekOfYear = date.weekOfYear
        cd_year = date.year
        cd_timeInterval = date.timeInterval
        cd_monthOfYear = date.monthOfYear
        cd_monthOfEra = date.monthOfEra
    }
}

extension CalendarDateManagedObject: CalendarDateProtocol {
    
    public var calendarIdentifier: String? { return cd_calendarIdentifier }
    public var dayOfEra: Int32 { return cd_dayOfEra }
    public var dayOfMonth: Int32 { return cd_dayOfMonth }
    public var dayOfYear: Int32 { return cd_dayOfYear }
    public var era: Int32 { return cd_era }
    public var weekOfEra: Int32 { return cd_weekOfEra }
    public var weekOfMonth: Int32 { return cd_weekOfMonth }
    public var weekOfYear: Int32 { return cd_weekOfYear }
    public var year: Int32 { return cd_year }
    public var timeInterval: Double { return cd_timeInterval }
    public var monthOfYear: Int32 { return cd_monthOfYear }
    public var monthOfEra: Int32 { return cd_monthOfEra }
}
