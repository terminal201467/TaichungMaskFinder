//
//  TaichungMaskFinderTests.swift
//  TaichungMaskFinderTests
//
//  Created by Jhen Mu on 2022/5/1.
//

import XCTest
@testable import TaichungMaskFinder

class TaichungMaskFinderTests: XCTestCase {
    
    var sut:ViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
