//
//  Model.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/27.
//

import Foundation


struct Model:Decodable{
    let type:String
    let features:Feature
    
    struct Feature:Decodable{
        let type:String
        let properties:Properties
        let geometry:Geometry
        
        struct Properties:Decodable {
            let id:String
            let name:String
            let phone:String
            let adress:String
            let mask_Adult:Int
            let mask_Child:Int
            let updated:String
            let available:String
            let note:String
            let custom:String
            let website:String
            let county:String
            let town:String
            let cunli:String
            let serve_period:String
        }
        
        struct Geometry:Decodable{
            let type:String
            let coordinate:[Double]
        }
    }
    
    
}
