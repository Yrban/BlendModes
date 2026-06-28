//
//  BlendModesUITestsLaunchTests.swift
//  BlendModesUITests
//
//  Created by AlelinApps on 6/20/26.
//

import XCTest

final class BlendModesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func DemoTest() throws {
        let app = XCUIApplication()
        app.launch()

        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    
}
