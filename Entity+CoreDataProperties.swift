//
//  Entity+CoreDataProperties.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/27.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var cunli: String?
    @NSManaged public var custom_note: String?
    @NSManaged public var note: String?
    @NSManaged public var available: String?
    @NSManaged public var updated: String?
    @NSManaged public var mask_child: Int64
    @NSManaged public var mask_adult: Int64
    @NSManaged public var address: String?
    @NSManaged public var phone: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var town: String?
    @NSManaged public var county: String?
    @NSManaged public var website: String?
    @NSManaged public var service_periods: String?

}

extension Entity : Identifiable {

}
