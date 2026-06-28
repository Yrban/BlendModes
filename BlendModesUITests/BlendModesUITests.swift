//
//  BlendModesUITests.swift
//  BlendModesUITests
//
//  Created by AlelinApps on 6/20/26.
//

import XCTest

final class BlendModesUITests: XCTestCase {

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
        // XCUIAutomation Documentation
        // https://developer.apple.com/documentation/xcuiautomation
    }

    @MainActor
    func testDemoPresetCirclesSetColorBlendMode() throws {
        let app = XCUIApplication()
        app.launch()
        
        Thread.sleep(forTimeInterval: 5)

        // Load the Demo preset via the Add Layer menu
        app.menuButtons["Add Layer"].click()
        app.menuItems["Demo"].click()

        // Demo has 3 circle layers. On macOS, List renders as NSOutlineView.
        // The first 3 DisclosureTriangles (indices 0–2) correspond to the 3 circle layers.
        let outline = app.outlines.firstMatch
        XCTAssertTrue(outline.waitForExistence(timeout: 0.5))

        for index in 0..<3 {
            let triangle = outline.disclosureTriangles.element(boundBy: index)
            XCTAssertTrue(triangle.waitForExistence(timeout: 0.5))
            triangle.click() // expand

            // The Picker(.menu) on macOS renders as a PopUpButton labeled with the current
            // selection, not the picker's "Blend Mode" label. Use firstMatch since only one
            // row is expanded at a time.
            let picker = outline.popUpButtons.firstMatch
            XCTAssertTrue(picker.waitForExistence(timeout: 0.5))
            picker.click()
            app.menuItems[".color"].click()

            triangle.click() // collapse before moving to the next row
        }

        Thread.sleep(forTimeInterval: 1)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
