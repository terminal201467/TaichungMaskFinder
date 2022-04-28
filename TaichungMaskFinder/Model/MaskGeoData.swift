//
//  Model.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/27.
//

import Foundation


struct MaskGeoData:Decodable{
    let type:String
    var features:[Feature]
    
    struct Feature:Decodable{
        let type:String
        let properties:Properties
        let geometry:Geometry
        
        struct Properties:Decodable {
            let id:String
            let name:String
            let phone:String
            let address:String
            let mask_adult:Int
            let mask_child:Int
            let updated:String
            let available:String
            let note:String
            let custom_note:String
            let website:String
            let county:String
            let town:String
            let cunli:String
            let service_periods:String
        }
        
        struct Geometry:Decodable{
            let type:String
            let coordinates:[Double]
        }
    }
}
