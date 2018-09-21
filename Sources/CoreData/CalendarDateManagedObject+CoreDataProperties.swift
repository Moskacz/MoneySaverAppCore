//
//  CalendarDateManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21/09/2018.
//
//

import Foundation
import CoreData


extension CalendarDateManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarDateManagedObject> {
        return NSFetchRequest<CalendarDateManagedObject>(entityName: "CalendarDateManagedObject")
    }

    @NSManaged public var cd_calendarIdentifier: String?
    @NSManaged public var cd_dayOfEra: Int32
    @NSManaged public var cd_dayOfMonth: Int32
    @NSManaged public var cd_dayOfWeek: Int32
    @NSManaged public var cd_dayOfYear: Int32
    @NSManaged public var cd_era: Int32
    @NSManaged public var cd_monthOfEra: Int32
    @NSManaged public var cd_monthOfYear: Int32
    @NSManaged public var cd_timeInterval: Double
    @NSManaged public var cd_weekOfEra: Int32
    @NSManaged public var cd_weekOfMonth: Int32
    @NSManaged public var cd_weekOfYear: Int32
    @NSManaged public var cd_year: Int32
    @NSManaged public var transaction: TransactionManagedObject?

}
