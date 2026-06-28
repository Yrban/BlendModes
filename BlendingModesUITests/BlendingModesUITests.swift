//
//  BlendingModesUITests.swift
//  BlendingModesUITests
//
//  Created by AlelinApps on 6/28/26.
//

import XCTest

final class BlendingModesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testDemoPresetCirclesSetColorBlendMode_iOS() throws {
        let app = XCUIApplication()
        app.launch()

        // Expand the bottom sheet by dragging the grab handle to the top of the screen
        let grabber = app.buttons["Sheet Grabber"].firstMatch
        XCTAssertTrue(grabber.waitForExistence(timeout: 0.5))
        grabber.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            .press(forDuration: 0.1, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.02)))

        // Load Demo preset
        app.images["plus.circle.fill"].firstMatch.tap()
        app.buttons["Demo"].firstMatch.tap()

        for index in 0..<3 {
            // Tap the row to expand the disclosure group
            let cell = app.collectionViews.firstMatch.cells.element(boundBy: index)
            XCTAssertTrue(cell.waitForExistence(timeout: 0.5))
            cell.tap()

            // Tap the blend mode picker — button label is "Blend Mode, .normal"; tap its static text
            let pickerButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Blend Mode,'")).firstMatch
            XCTAssertTrue(pickerButton.waitForExistence(timeout: 0.5))
            pickerButton.staticTexts.firstMatch.tap()

            // Scroll the picker menu to reveal the Component section
            let midPicker = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6))
            let topPicker = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
            midPicker.press(forDuration: 0.05, thenDragTo: topPicker)
            midPicker.press(forDuration: 0.05, thenDragTo: topPicker)

            // Select .color
            app.buttons[".color"].firstMatch.tap()

            // Collapse the row before moving to the next
            cell.tap()
        }

        // Drop the sheet back down
        grabber.swipeDown()

        Thread.sleep(forTimeInterval: 1)
    }

    @MainActor
    func testDemoPresetCirclesSetColorBlendMode_iPad() throws {
        // Targets iPad (regular horizontal size class) where the layer list
        // is in a NavigationSplitView sidebar that starts hidden (.detailOnly)
        let app = XCUIApplication()
        app.launch()

        // Show the sidebar — NavigationSplitView provides a toolbar toggle button
        let sidebarToggle = app.buttons["Show Sidebar"].firstMatch
        if sidebarToggle.waitForExistence(timeout: 0.5) {
            sidebarToggle.tap()
        }

        // Load Demo preset
        app.buttons["Add Layer"].firstMatch.tap()
        app.buttons["Demo"].firstMatch.tap()

        for index in 0..<3 {
            // Tap the row to expand the disclosure group
            let cell = app.collectionViews.firstMatch.cells.element(boundBy: index)
            XCTAssertTrue(cell.waitForExistence(timeout: 0.5))
            cell.tap()

            // Tap the blend mode picker — button label is "Blend Mode, .normal"; tap its static text
            let pickerButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Blend Mode,'")).firstMatch
            XCTAssertTrue(pickerButton.waitForExistence(timeout: 0.5))
            pickerButton.staticTexts.firstMatch.tap()

            // Scroll the picker menu to reveal the Component section
            let midPicker = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6))
            let topPicker = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
            midPicker.press(forDuration: 0.05, thenDragTo: topPicker)
//            midPicker.press(forDuration: 0.05, thenDragTo: topPicker)

            // Select .color
            app.buttons[".color"].firstMatch.tap()

            // Collapse the row before moving to the next
            cell.tap()
        }

        Thread.sleep(forTimeInterval: 1)
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
