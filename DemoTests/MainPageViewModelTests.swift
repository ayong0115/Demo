//
//  MainPageViewModelTests.swift
//  DemoTests
//
//  Created by 高涌 on 2020/11/1.
//

import XCTest
@testable import Demo


class MainPageViewModelTests: XCTestCase {
    var startTime:Date?
    var endTime:Date?
    var stub:MainPageViewModel?
    var exp:XCTestExpectation?
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testStartRegularRefresh() {
        stub = MainPageViewModelFactory.createMainPageViewModel(aDelegate: self)
        XCTAssert(stub?.numberOfRecord() == 0)
        startTime = Date()
        exp = self.expectation(description: "wait")
        stub!.startRegularRefresh()
        self.wait(for: [exp!], timeout: 10)
    }

}

extension MainPageViewModelTests : MainPageViewModelDelegate {
    func fetchWithError(error: NSError) {
        
    }
    
    func fetchSuccess() {
        
        let interval = Date().timeIntervalSince(startTime!)
        if interval > 5 {
            XCTAssert(interval < 9)
            XCTAssert(stub?.numberOfRecord() == 1)
            exp!.fulfill()
        }else{
            XCTAssert(stub?.numberOfRecord() == 1)
        }
    }
    
    
}
