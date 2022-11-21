//
//  API_ProgrammaticUI_PracticeTests.swift
//  API-ProgrammaticUI-PracticeTests
//
//  Created by Matthew David Fleischer on 17/11/2022.
//

import XCTest
@testable import API_ProgrammaticUI_Practice

final class API_ProgrammaticUI_PracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //test that array is empty before search
        let svc = SearchViewController()
        XCTAssertTrue(svc.jokesReturned.count == 0)
        
        //tests that joke array has size 100
        let vc = ViewController()
        XCTAssertTrue(vc.jokes.count == 100)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
