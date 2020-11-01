//
//  HistoryViewModelTest.swift
//  DemoTests
//
//  Created by 高涌 on 2020/11/1.
//

import XCTest
@testable import Demo
class HistoryViewModelTest: XCTestCase {
    var stub:HistoryViewModel?
    var exp:XCTestExpectation?
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadHistory () {
        stub = HistoryViewModelFactory.createHisotryViewModel(aDelegate: self)
        XCTAssert(stub!.numberOfHistory() == 0)
        XCTAssertNil(stub!.resultFor(indexpath: IndexPath(row: 0, section: 0)))
        exp = self.expectation(description: "wait")
        stub!.loadHistory()
        self.wait(for: [exp!], timeout: 10)
    }


}
extension HistoryViewModelTest:HistoryViewModelDelegate{
    func fetchWithError(error: NSError) {
        XCTAssert(stub!.numberOfHistory() == 0)
        XCTAssertNil(stub!.resultFor(indexpath: IndexPath(row: 0, section: 0)))
        exp!.fulfill()
    }
    
    func fetchSuccess() {
        XCTAssert(stub!.numberOfHistory() > 0)
        XCTAssertNotNil(stub!.resultFor(indexpath: IndexPath(row: 0, section: 0)))
        exp!.fulfill()
    }
    
    
}

