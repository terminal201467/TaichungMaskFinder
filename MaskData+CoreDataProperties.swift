//
//  MaskData+CoreDataProperties.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/28.
//
//

import Foundation
import CoreData


extension MaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaskData> {
        return NSFetchRequest<MaskData>(entityName: "MaskData")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var address: String?
    @NSManaged public var available: String?
    @NSManaged public var county: String?
    @NSManaged public var cunli: String?
    @NSManaged public var custom_note: String?
    @NSManaged public var mask_adult: Int
    @NSManaged public var mask_child: Int
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var phone: String?
    @NSManaged public var service_period: String?
    @NSManaged public var town: String?
    @NSManaged public var update: String?
    @NSManaged public var website: String?
    @NSManaged public var relationship: MaskData?

}

extension MaskData : Identifiable {

}
