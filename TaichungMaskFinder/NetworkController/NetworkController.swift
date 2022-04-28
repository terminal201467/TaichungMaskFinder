//
//  NetworkController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit
import CoreData
import Alamofire
import SwiftUI

//取得台中地區的口罩數量，資料需存入 Local 資料庫 (Core Data)
//UI需顯示列表瀏覽口罩數量且能依照區域做篩選
//提供刪除某一筆資料的功能
//抓取資料來源的每日一句一併顯示於畫面上
//程式架構須符合 MVC-n

class NetworkController: NSObject {
    
    //MARK:-Binding
    var valueChanged:(()->Void)?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var getNetworksData:[MaskGeoData.Feature] = []
    
    //MARK:-Properties
    var container:NSPersistentContainer!
    
    let baseURL:String = "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"

    //MARK:-GetMethod
    func getData(){
        AF.request(baseURL).responseJSON { response in
            debugPrint("Status:\(response.response?.statusCode)")
            if let data = response.data{
                print("data:",data)
                do{
                    let decode = try JSONDecoder().decode(MaskGeoData.self, from: data)
                    self.getNetworksData = decode.features
                    print(self.getNetworksData)
                }catch{
                    print("error:",error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:-SelectObject
    func selectObject()->Array<MaskData>{
        var array:[MaskData] = []
        let request = NSFetchRequest<MaskData>(entityName: "MaskData")
        do{
            let results = try self.context.fetch(request)
            for result in results {
                array.append(result)
            }
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return array
    }
    
    
    //MARK:-InsertObject
    func insertObject(feature:MaskGeoData.Feature){
        let member = NSEntityDescription.insertNewObject(forEntityName: "MaskGeoData", into: self.context) as! MaskData
        member.id = feature.properties.id
        member.address = feature.properties.address
        member.available = feature.properties.available
        member.county = feature.properties.county
        member.note = feature.properties.note
        member.custom_note = feature.properties.custom_note
        member.mask_adult = feature.properties.mask_adult
        member.mask_child = feature.properties.mask_child
        member.phone = feature.properties.phone
        member.county = feature.properties.county
        member.cunli = feature.properties.cunli
        member.service_period = feature.properties.service_periods
        member.website = feature.properties.website
        member.town = feature.properties.town
        member.name = feature.properties.name
        member.update = feature.properties.updated
        do{
            try self.context.save()
        }catch{
            fatalError("\(error)")
        }
    }
    
    //MARK:-DeleteObject
    func deleteObject(){
        let request = NSFetchRequest<Member>(entityName:"Member")
        do{
            let results = try self.context.fetch(request)
            for item in results{
                if item.
            }
        }catch{

        }
    }
    
    
    
    
    //MARK:-SaveContext
    func saveContext(){
        let context = container.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolve error:\(nserror),\(nserror.userInfo)")
            }
        }
    }
}

extension NSPersistentContainer{
    func saveContext(){
        if viewContext.hasChanges{
            do{
                try viewContext.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolve error:\(nserror),\(nserror.userInfo)")
            }
        }
    }
    
}
