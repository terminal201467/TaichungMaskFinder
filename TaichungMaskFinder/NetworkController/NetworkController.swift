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
    
    //MARK:-Properties
    var container:NSPersistentContainer!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectArea:String = ""{
        didSet{
//            filterCunli(cunli: self.selectArea)
        }
    }
    
    private var taichungData:[MaskGeoData.Feature.Properties] = []{
        didSet{
            valueChanged?()
//            print("taichungData:",taichungData)
            
//            taichungData.map{insertObject(feature: $0)}
            
            self.townData = taichungData.map{$0.town}.sorted().removingDuplicates()
        }
    }
    
    var getNetworksData:[MaskGeoData.Feature] = []{
        didSet{
            valueChanged?()
            filterCounty(county:"臺中市")
        }
    }
    
    var localData:[MaskData] = []{
        didSet{
            valueChanged?()
        }
    }
    
    var townData:[String] = []
    
    private let baseURL:String = "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"

    //MARK:-GetMethod
    func getData(){
        AF.request(baseURL).responseJSON { response in
            debugPrint("Status:\(response.response?.statusCode)")
            if let data = response.data{
                print("data:",data)
                do{
                    let decode = try JSONDecoder().decode(MaskGeoData.self, from: data)
                    self.getNetworksData = decode.features
//                    print("數量：",self.getNetworksData.count)
                }catch{
                    print("error:",error.localizedDescription)
                }
            }
        }
    }
    
    func filterCounty(county:String){
        for data in getNetworksData{
            if data.properties.county == county {
//                print("\(county)資料:",data.properties)
                taichungData.append(data.properties)
            }
        }
    }
    
    func filterTown(town:String){
        for data in taichungData{
            if data.town == town{
                taichungData.removeAll()
                taichungData.append(data)
            }
        }
    }
    
    //MARK:-SelectObject
    func selectObject()->Array<MaskData>{
        var array:[MaskData] = []
        let request:NSFetchRequest<MaskData> = MaskData.fetchRequest()
        do{
            let results = try self.context.fetch(request)
            for result in results { array.append(result) }
        }catch{
            fatalError("Failed to fetch data: \(error.localizedDescription)")
        }
        return array
    }
    
    //MARK:-InsertObject
    func insertObject(feature:MaskGeoData.Feature.Properties){
        let member = NSEntityDescription.insertNewObject(forEntityName: "MaskData", into: self.context) as! MaskData
        member.id = feature.id
        member.address = feature.address
        member.available = feature.available
        member.county = feature.county
        member.note = feature.note
        member.custom_note = feature.custom_note
        member.mask_adult = feature.mask_adult
        member.mask_child = feature.mask_child
        member.phone = feature.phone
        member.county = feature.county
        member.cunli = feature.cunli
        member.service_period = feature.service_periods
        member.website = feature.website
        member.town = feature.town
        member.name = feature.name
        member.update = feature.updated
        do{
            try self.context.save()
            print("Save")
        }catch{
            fatalError("\(error)")
        }
        self.localData = self.selectObject()
    }
    
    //MARK:-DeleteObject
    func deleteObject(indexPath:IndexPath){
        let request:NSFetchRequest<MaskData> = MaskData.fetchRequest()
        context.delete(localData[indexPath.row])
        do{
            let results = try self.context.fetch(request)
            try self.context.save()
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //MARK:-updateObject
    func updateObject(indexPath:IndexPath){
        let request = NSFetchRequest<MaskData>(entityName: "MaskData")
        do{
            let results = try self.context.fetch(request)
            results.map { data in
                data.id = localData[indexPath.row].id
                data.name = localData[indexPath.row].name
                data.address = localData[indexPath.row].address
                data.phone = localData[indexPath.row].phone
                data.note = localData[indexPath.row].note
                data.custom_note = localData[indexPath.row].custom_note
                data.website = localData[indexPath.row].website
                data.mask_adult = localData[indexPath.row].mask_adult
                data.mask_child = localData[indexPath.row].mask_child
                data.available = localData[indexPath.row].available
                data.county = localData[indexPath.row].county
                data.cunli = localData[indexPath.row].cunli
                data.town = localData[indexPath.row].town
                data.update = localData[indexPath.row].update
                data.service_period = localData[indexPath.row].service_period
            }
            try self.context.save()
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //MARK:-AlamoGetData
    func numberOfRowsInSection(_ section:Int)->Int{
        return taichungData.count
    }
    
    func getData(_ indexPath:IndexPath)->MaskGeoData.Feature.Properties{
        return taichungData[indexPath.row]
    }
    
    //MARK:PickView
    func numberOfRowsInComponent(_ component:Int)->Int{
//        print("村里數：",taichungData.map{$0.cunli}.count)
        return townData.count == 0 ? 0 : townData.count
    }
    
    func titleForRow(_ row:Int)->String{
//        print("村里：",taichungData[row].cunli)
        return townData.count == 0 ? "沒有區域" : townData[row]
    }
    
    func deleteRow(_ indexPath:IndexPath){
        //the coreData need to delete data here
        taichungData.remove(at: indexPath.row)
    }
    
    //MARK:-MaskData
    func numberOfRowInSectionFromLocel(_ section:Int)->Int{
        return localData.count
    }
    
    func getData(_ indexPath:IndexPath)->MaskData{
        return localData[indexPath.row]
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
