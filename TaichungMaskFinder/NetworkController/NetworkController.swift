//
//  NetworkController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit
import CoreData
import Alamofire

//取得台中地區的口罩數量，資料需存入 Local 資料庫 (Core Data)
//UI需顯示列表瀏覽口罩數量且能依照區域做篩選
//提供刪除某一筆資料的功能
//抓取資料來源的每日一句一併顯示於畫面上
//程式架構須符合 MVC-n

class NetworkController: NSObject {
    
    //MARK:-Properties
    var container:NSPersistentContainer!
    
    let baseURL:String = "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"

    //MARK:-GetMethod
    func getData(){
        AF.request(baseURL).responseJSON { (response) in
            print("status:\(response.response?.statusCode)")
            switch response.result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do{
                    let decode = try JSONDecoder().decode(Model.self, from: data as! Data)
                    print("Json:",decode)
                }catch{
                    print(error)
                }
            }
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
