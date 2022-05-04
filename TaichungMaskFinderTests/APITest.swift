//
//  APITest.swift
//  TaichungMaskFinderTests
//
//  Created by Jhen Mu on 2022/5/1.
//

import XCTest
import Network
@testable import TaichungMaskFinder

class APITest: XCTestCase {
    
    var sutAPI:URLSession!
    var sutNetwork:NetworkController!
    var sutSentenceEveryDay:SentenceEveryDayController!
    let monitor = NWPathMonitor()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sutNetwork = NetworkController()
        sutAPI = URLSession(configuration: .default)
        sutSentenceEveryDay = SentenceEveryDayController()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sutNetwork = nil
        sutAPI = nil
        sutSentenceEveryDay = nil
    }
    
    func testMaskGeoDataGetsHttpStatusCode200()throws{
        let url = URL(string: "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json")!
        let promise = expectation(description: "Status Code：200")
        var statusCode:Int?
        var responseError:Error?
        
        let dataTask = sutAPI.dataTask(with: url) { _ , response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testEveryDaySentenceHttpStatusCode200()throws{
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

    func testGetGeoData() throws {
        sutNetwork.loadData()
        XCTAssertNotNil(sutNetwork.localData)
        
        sutNetwork.removeLocalData()
        XCTAssertTrue(sutNetwork.localData.isEmpty)
    }
    
    func testFilterMethod()throws{
        sutNetwork.loadData()
        sutNetwork.filterTown(town:"后里區")
        XCTAssertNotNil(sutNetwork.localData)
    }
    
    func testTableViewMethod()throws{
        sutNetwork.loadData()
        let rows = sutNetwork.numberOfRowsInSection(0)
        XCTAssertNotNil(rows)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
