//
//  enums.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/29.
//

import Foundation


enum ItemName:Int{
    case pharmacy = 0,maskKind,info,area
    var text:String{
        switch self{
        case .pharmacy: return "藥局名稱"
        case .maskKind: return "口罩別"
        case .info:     return "資訊"
        case .area:     return "區域篩選"
        }
    }
}

enum CellTitle:Int{
    case phone = 0,address,time
    var text:String{
        switch self{
        case .phone:    return "電話"
        case .address:  return "地址"
        case .time:     return "時間"
        }
    }
}

enum TiteSize:Int{
    case title = 0,celltitle
    var Size:Double{
        switch self{
        case .title:      return 20
        case .celltitle:  return 15
        }
    }
    
}
