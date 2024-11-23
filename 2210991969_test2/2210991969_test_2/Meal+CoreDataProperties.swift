//
//  Meal+CoreDataProperties.swift
//  2210991969_test_2
//
//  Created by student-2 on 23/11/24.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
    @NSManaged public var category: String?
    @NSManaged public var calories: Int16
    @NSManaged public var prepTime: Int16
    @NSManaged public var image: Data?

}


