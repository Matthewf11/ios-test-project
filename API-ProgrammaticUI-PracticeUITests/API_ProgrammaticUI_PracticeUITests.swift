//
//  API_ProgrammaticUI_PracticeUITests.swift
//  API-ProgrammaticUI-PracticeUITests
//
//  Created by Matthew David Fleischer on 17/11/2022.
//

import XCTest

final class API_ProgrammaticUI_PracticeUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testMultipleWords() throws {
        app.launch()
        app.buttons["Dictionary"].tap()
        app.textFields["queryParameter"].tap()
        app.textFields["queryParameter"].typeText("race car")
        app.buttons["SearchButton"].tap()
        print(app.tables["dictionaryResults"].cells.count)
        sleep(2)
        XCTAssert(app.tables["dictionaryResults"].cells.count == 10)
    }

    func testApiAndSearchApi() throws {
        // UI tests must launch the application that they test.
        app.launch()
        app.buttons["Dictionary"].tap()
        XCTAssert(app.tables["dictionaryResults"].cells.count == 0)
        app.textFields["queryParameter"].tap()
        app.textFields["queryParameter"].typeText("Car")
        app.buttons["SearchButton"].tap()
        sleep(2)
        print(app.tables["dictionaryResults"].cells.count)
        XCTAssert(app.tables["dictionaryResults"].cells.count == 10)
        //print(app.tables["tableView"].cells.count)
        XCTAssert(app.tables["tableView"].cells.count == 100)
        app.swipeDown(velocity:XCUIGestureVelocity.fast)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.buttons["JokeSearch"].tap()
        app.textFields["SearchTextField"].tap()
        app.textFields["SearchTextField"].typeText("Car")
        app.buttons["SearchButton"].tap()
        XCTAssert(app.tables["SearchResults"].cells.count == 308)
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
