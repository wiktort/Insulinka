//
//  InsulinkaUITests.swift
//  InsulinkaUITests
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import XCTest
@testable import Insulinka

class InsulinkaUITests: XCTestCase {
    var app: XCUIApplication!
    let device = XCUIDevice.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        device.orientation = UIDeviceOrientation.portrait
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testTabView() throws {
        // given
        let tabBar = XCUIApplication().tabBars["Tab Bar"]

        let startButton = tabBar.buttons["Start"]
        let calculatorButton = tabBar.buttons["Kalkulator"]
        let mealsButton = tabBar.buttons["Dania"]
        let settingsButton = tabBar.buttons["Ustawienia"]
        
        let logo = app.images["logo"]
        let calculatorViewHeader = app.navigationBars["Kalkulator"].staticTexts["Kalkulator"]
        let mealsViewHeader = app.navigationBars["Lista dań"].staticTexts["Lista dań"]
        let settingsViewHeader = app.navigationBars["Ustawienia"].staticTexts["Ustawienia"]
        
        // then
        if startButton.isSelected {
            XCTAssertTrue(logo.exists)
            XCTAssertFalse(calculatorViewHeader.exists)
            XCTAssertFalse(mealsViewHeader.exists)
            XCTAssertFalse(settingsViewHeader.exists)
    
            calculatorButton.tap()
            
            XCTAssertTrue(calculatorViewHeader.exists)
        } else if calculatorButton.isSelected {
            XCTAssertTrue(calculatorViewHeader.exists)
            XCTAssertFalse(logo.exists)
            XCTAssertFalse(mealsViewHeader.exists)
            XCTAssertFalse(settingsViewHeader.exists)

            mealsButton.tap()
            
            XCTAssertTrue(mealsViewHeader.exists)
        } else if mealsButton.isSelected {
            XCTAssertTrue(mealsViewHeader.exists)
            XCTAssertFalse(calculatorViewHeader.exists)
            XCTAssertFalse(logo.exists)
            XCTAssertFalse(settingsViewHeader.exists)
            
            settingsButton.tap()
            
            XCTAssertTrue(settingsViewHeader.exists)
        } else if settingsButton.isSelected {
            XCTAssertTrue(settingsViewHeader.exists)
            XCTAssertFalse(mealsViewHeader.exists)
            XCTAssertFalse(calculatorViewHeader.exists)
            XCTAssertFalse(logo.exists)
            
            startButton.tap()
            
            XCTAssertTrue(logo.exists)
        }
                
    }
}
