//
//  extensions.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/5/1.
//

import Foundation


extension Array where Element: Hashable{
    
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
          addedDict.updateValue(true, forKey: $0) == nil
        }
     }
    
     mutating func removeDuplicates() {
        self = self.removingDuplicates()
     }
}
