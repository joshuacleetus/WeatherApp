//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Joshua Cleetus on 5/15/25.
//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testForecastListAppears() throws {
        let app = XCUIApplication()
        app.launch()

        // Assert the title exists
        let title = app.staticTexts["7 Day Forecast"]
        XCTAssertTrue(title.exists)

        // Wait for the first row (forecast day) to appear
        let firstCell = app.cells.element(boundBy: 0)
        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Expected forecast row to load in list")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
