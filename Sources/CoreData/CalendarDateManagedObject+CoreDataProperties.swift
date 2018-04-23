//
//  CalendarDateManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData


extension CalendarDateManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarDateManagedObject> {
        return NSFetchRequest<CalendarDateManagedObject>(entityName: "CalendarDateManagedObject")
    }

    @NSManaged public var calendarIdentifier: String?
    @NSManaged public var dayOfEra: Int32
    @NSManaged public var dayOfMonth: Int32
    @NSManaged public var dayOfWeek: Int32
    @NSManaged public var dayOfYear: Int32
    @NSManaged public var era: Int32
    @NSManaged public var monthOfEra: Int32
    @NSManaged public var monthOfYear: Int32
    @NSManaged public var timeInterval: Double
    @NSManaged public var weekOfEra: Int32
    @NSManaged public var weekOfMonth: Int32
    @NSManaged public var weekOfYear: Int32
    @NSManaged public var year: Int32
    @NSManaged public var transaction: TransactionManagedObject?

}
