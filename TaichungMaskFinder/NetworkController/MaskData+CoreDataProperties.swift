//
//  Model+CoreDataProperties.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/27.
//
//

import Foundation
import CoreData


extension MaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaskData> {
        return NSFetchRequest<MaskData>(entityName: "MaskData")
    }


}

extension MaskData : Identifiable {
    
}
