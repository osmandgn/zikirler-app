//
//  ZikirlerUITests.swift
//  ZikirlerUITests
//
//  Created by osman dogan on 15.05.2025.
//

import XCTest

final class ZikirlerUITests: XCTestCase {

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
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    @MainActor
    func testNavigateToStatisticsView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // 1. Verify the "İstatistikleri Görüntüle" button/link exists and tap it.
        // In SwiftUI, NavigationLink containing Text will often make the Text its accessibility label.
        let statisticsButton = app.buttons["İstatistikleri Görüntüle"]
        
        // It's good to wait for the element to exist, especially in UI tests.
        XCTAssertTrue(statisticsButton.waitForExistence(timeout: 5), "The 'İstatistikleri Görüntüle' button should exist.")
        statisticsButton.tap()

        // 2. Verify that the navigation occurs and the StatisticsView is displayed.
        // We check for the navigation bar title of StatisticsView.
        // Note: `navigationBars` elements are identified by their title.
        let statisticsNavBar = app.navigationBars["İstatistikler"]
        XCTAssertTrue(statisticsNavBar.waitForExistence(timeout: 5), "The 'İstatistikler' navigation bar should be visible after tapping the button.")
        
        // 3. Optionally, verify some content on the StatisticsView
        // For example, checking for the main title text if it's made accessible.
        // Let's assume the "İstatistikler" title within the VStack is also identifiable.
        // If it's a staticText, we can look for it.
        // This depends on how `Text("İstatistikler").font(.largeTitle)` is rendered for accessibility.
        // Often, direct Text elements used as titles are also queryable.
        let statisticsViewTitle = app.staticTexts["İstatistikler"]
        XCTAssertTrue(statisticsViewTitle.exists, "The 'İstatistikler' title text should be visible on the StatisticsView.")
    }
}
