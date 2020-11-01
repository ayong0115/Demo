//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by 高涌 on 2020/11/1.
//

import XCTest

class DemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigation() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let showHistoryButton = app.navigationBars["Demo.MainView"].buttons["show history"]
        showHistoryButton.tap()
        
        let backButton = app.navigationBars["History"].buttons["Back"]
        backButton.tap()
        showHistoryButton.tap()
        backButton.tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
}
