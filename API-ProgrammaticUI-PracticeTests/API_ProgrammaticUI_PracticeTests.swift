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
        var mds = MockDictionaryService()
        var dvc = DictionaryViewController(dictionaryService: mds)
        var response = Definitions(list: [
            Definition(thumbs_up: 100),
            Definition(thumbs_up: 902),
            Definition(thumbs_up: 430),
            Definition(thumbs_up: 3202),
            Definition(thumbs_up: 22220)
        ])

        dvc.handleResponse(response: response)
        let actualResult = dvc.dictionaryResponse.map{$0.thumbs_up}
        let expectedResult = [22220,3202,902,430,100]
        
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
