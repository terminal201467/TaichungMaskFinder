//
//  TaichungMaskFinderUITests.swift
//  TaichungMaskFinderUITests
//
//  Created by Jhen Mu on 2022/5/3.
//

import XCTest

class TaichungMaskFinderUITests: XCTestCase {
    
    var app:XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

        func testExample() throws {

    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
