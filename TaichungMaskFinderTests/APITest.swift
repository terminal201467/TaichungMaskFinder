//
//  APITest.swift
//  TaichungMaskFinderTests
//
//  Created by Jhen Mu on 2022/5/1.
//

import XCTest
@testable import TaichungMaskFinder

class APITest: XCTestCase {
    
    var sutAPI:URLSession!
    var sutNetwork:NetworkController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sutNetwork = NetworkController()
        sutAPI = URLSession(configuration: .default)
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sutNetwork = nil
        sutAPI = nil
    }
    
    func testMaskGeoDataGetsHttpStatusCode200(){
        let url = URL(string: "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json")!
        let promise = expectation(description: "Status Code：200")
        
        let dataTask = sutAPI.dataTask(with: url) { _ , response, error in
            if let error = error{
                XCTFail("Error:\(error.localizedDescription)")
                return
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }else{
                    XCTFail("Status Code:\(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testEveryDaySentenceHttpStatusCode200(){
        let url = URL(string: "https://tw.feature.appledaily.com/collection/dailyquote")!
        let promise = expectation(description: "Status Code：200")
        
        let dataTask = sutAPI.dataTask(with: url) { _, response, error in
            if let error = error{
                XCTFail("Error:\(error.localizedDescription)")
                return
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }else{
                    XCTFail("Status Code:\(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }

    func testNetworkGetData() throws {
        sutNetwork.loadData()
        XCTAssertNotNil(sutNetwork.localData)
        
        sutNetwork.removeLocalData()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
