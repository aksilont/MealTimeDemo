//
//  Meal+CoreDataProperties.swift
//  MealTime
//
//  Created by Aksilont on 01.06.2021.
//
//

import Foundation
import CoreData

extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var date: Date?
    @NSManaged public var person: Person?

}

extension Meal : Identifiable {

}
