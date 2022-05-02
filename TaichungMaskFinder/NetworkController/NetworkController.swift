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

class NetworkController: NSObject{
    
    //MARK:-Binding
    var valueChanged:(()->Void)?
    
    //MARK:-Properties
    private var container:NSPersistentContainer!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private let fetchRequest:NSFetchRequest<MaskData> = MaskData.fetchRequest()
    
    private let sortDescription = NSSortDescriptor(key: "name", ascending: true)
    
    private var fetchResultController:NSFetchedResultsController<MaskData>!
    
    //MARK:-GCD
    let serialQueue:DispatchQueue = DispatchQueue(label: "SerialQueue")
    
    //MARK:-searchData
    
    public var selectArea:String = ""
    
    private var taichungData:[MaskGeoData.Feature.Properties] = []
    
    var townData:[String] = []
    
    var localData:[MaskData] = []{
        didSet{
            valueChanged?()
            self.townData = localData.map{$0.town!}.sorted().removingDuplicates()
        }
    }
    
    private let baseURL:String = "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"

    //MARK:-GetMethod
    func loadData(){
        AF.request(baseURL).responseJSON { response in
            debugPrint("Status:\(response.response?.statusCode)")
            if let data = response.data{
                print("data:",data)
                do{
                    let decode = try JSONDecoder().decode(MaskGeoData.self, from: data)
//                    print("DB:",NSPersistentContainer.defaultDirectoryURL)
                    self.serialQueue.async {
                        self.filterCounty(loadData: decode, county: "臺中市")
                    }
                }catch{
                    print("error:",error.localizedDescription)
                }
            }
        }
    }
    
    func filterCounty(loadData:MaskGeoData,county:String){
        for data in loadData.features{
            if data.properties.county == county {
                taichungData.append(data.properties)
                insertObject(feature: data.properties)
            }
        }
    }
    
    func filterTown(town:String){
        var filterData:[MaskData] = []
        for data in localData{
            if data.town == town{
                localData.removeAll()
                filterData.append(data)
            }
        }
        localData = filterData
    }
    
    //MARK:-SelectObject
    func selectObject()->Array<MaskData>{
        var array:[MaskData] = []
        let request:NSFetchRequest<MaskData> = MaskData.fetchRequest()
        do{
            let results = try self.appDelegate.persistentContainer.viewContext.fetch(request)
            for result in results { array.append(result) }
        }catch{
            fatalError("Failed to fetch data: \(error.localizedDescription)")
        }
        return array
    }
    
    //MARK:-InsertObject
    func insertObject(feature:MaskGeoData.Feature.Properties){
        let member = NSEntityDescription.insertNewObject(forEntityName: "MaskData", into: appDelegate.persistentContainer.viewContext) as! MaskData
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
            try self.appDelegate.persistentContainer.viewContext.save()
            print("Save")
        }catch{
            fatalError("\(error)")
        }
        self.localData = self.selectObject()
    }
    
    //MARK:-DeleteObject
    func deleteObject(indexPath:IndexPath){
        let request:NSFetchRequest<MaskData> = MaskData.fetchRequest()
        appDelegate.persistentContainer.viewContext.delete(localData[indexPath.row])
        do{
            let results = try self.appDelegate.persistentContainer.viewContext.fetch(request)
            try self.appDelegate.persistentContainer.viewContext.save()
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    func loadLocalObject(){
        fetchRequest.sortDescriptors = [sortDescription]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        do{
            try fetchResultController.performFetch()
            if let fetchObject = fetchResultController.fetchedObjects{
                localData = fetchObject
            }
        }catch{
            print(error)
        }
    }
    
    func numberOfRowsInSection(_ section:Int)->Int{
        return localData.count
    }
    
    func getData(_ indexPath:IndexPath)->MaskData{
        return localData[indexPath.row]
    }
    //MARK:PickView
    func numberOfRowsInComponent(_ component:Int)->Int{
        return townData.count == 0 ? 0 : townData.count
    }
    
    func titleForRow(_ row:Int)->String{
        return localData.count == 0 ? "沒有區域" : townData[row]
    }
    
    func removeTaichungData(){
        taichungData.removeAll()
        localData.removeAll()
    }
    
    func deleteRow(_ indexPath:IndexPath){
        //the coreData need to delete data here
        taichungData.remove(at: indexPath.row)
        deleteObject(indexPath: indexPath)
    }
    
    //MARK:-MaskData
    func numberOfRowInSectionFromLocel(_ section:Int)->Int{
        return localData.count
    }
    
    func getCellData(_ indexPath:IndexPath)->MaskData{
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

extension NetworkController:NSFetchedResultsControllerDelegate{
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type{
//        case .insert:
//
//        case .delete:
//
//        case .update:
//
//        default:
//
//        }
//    }
}
