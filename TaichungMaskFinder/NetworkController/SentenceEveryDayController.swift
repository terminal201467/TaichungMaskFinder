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
    
    private var sentenceArray:[Sentence] = []{
        didSet{
            print(sentenceArray)
        }
    }
    
    private let baseURL:String = "https://tw.feature.appledaily.com/collection/dailyquote"
    
    func loadData(){
        AF.request(baseURL).responseString { response in
            if let status = response.response?.statusCode{
                print("status:",status)
            }
            if let html = response.value{
                self.parsehtml(html)
            }
        }
    }
    
    func parsehtml(_ html:String){
        var doc = try? Kanna.HTML(html: html, encoding: .utf8)
        let sentence = doc!.xpath("/html/body/div/article/div/div/div/p[2]").first?.text
        let receiveSentence = sentence!.trimmingCharacters(in: .whitespacesAndNewlines)
        print(sentence!.trimmingCharacters(in: .whitespacesAndNewlines))
        let name = doc!.xpath("/html/body/div/article/div/div/div/h1").first?.text
        let receiveName = name!.trimmingCharacters(in: .whitespacesAndNewlines)
        print(name!.trimmingCharacters(in: .whitespacesAndNewlines))
        sentenceArray.append(Sentence(sentence: receiveSentence, name: receiveName))
    }
}
