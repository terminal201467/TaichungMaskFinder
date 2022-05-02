//
//  SentenceEveryDayController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/30.
//

import Alamofire
import Foundation
import Kanna

class SentenceEveryDayController{
    
    var valueChanged:(()->Void)?
    
    private let baseURL:String = "https://tw.feature.appledaily.com/collection/dailyquote"
    
    func getData(){
        AF.request(baseURL).responseString { response in
            if let status = response.response?.statusCode{
                print("status:",status)
            }
            if let html = response.value{
                
            }
        }
        
    }
    
    func parsehtml(_ html:String){
        var doc = try? Kanna.HTML(html: html, encoding: .utf8)
    }
    
    
    
    
    
}
