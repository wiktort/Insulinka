//
//  InsulinCalculatorViewTest.swift
//  InsulinkaUITests
//
//  Created by Wiktor Tumiński on 25/01/2022.
//

import XCTest

class InsulinCalculatorViewTest: XCTestCase {
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
        
        let calculatorTabButton = app.tabBars["Tab Bar"].buttons["Kalkulator"]
        calculatorTabButton.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }
    
    func testItShouldUpdateInsulinDosesWhenPropertiesAreChanged() throws {
        // given
        let tablesQuery = app.tables
        let fatsInput = tablesQuery.textFields["tłuszcze"]
        let proteinsInput = tablesQuery.textFields["białka"]
        let carbsInput = tablesQuery.textFields["węglowodany"]
        let mealWeightInput = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Podaj wagę posiłku"]/*[[".cells[\"Waga dania (gram), Podaj wagę posiłku\"].textFields[\"Podaj wagę posiłku\"]",".textFields[\"Podaj wagę posiłku\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(
            tablesQuery.cells["Dawka insuliny na 100g dania: 0.0"].exists,
            "Text in insulin dose per 100G section is incorrect or the section isn't displayed"
        )
        
        // when
        fatsInput.tap()
        fatsInput.typeText("10")
        
        // then
        XCTAssertTrue(tablesQuery.cells["Dawka insuliny na 100g dania: 0.9"].exists, "Insulin dose per 100G wasn't updated after fats update")
        
        // when
        proteinsInput.tap()
        proteinsInput.typeText("10")
        
        // then
        XCTAssertTrue(tablesQuery.cells["Dawka insuliny na 100g dania: 1.3"].exists, "Insulin dose per 100G wasn't updated after proteins update")
        
        
        // when
        carbsInput.tap()
        carbsInput.typeText("10")
        
        // then
        XCTAssertTrue(tablesQuery.cells["Dawka insuliny na 100g dania: 2.13"].exists, "Insulin dose per 100G wasn't updated after carbs update")
        XCTAssertTrue(
            tablesQuery.cells["Dawka insuliny na całe danie: n/a"].exists,
            "Text in insulin dose per meal section is incorrect or the section isn't displayed"
        )
        
        // when
        mealWeightInput.tap()
        mealWeightInput.typeText("250")

        // then
        XCTAssertTrue(
            tablesQuery.cells["Dawka insuliny na całe danie: 5.33"].exists,
            "Insulin dose per meal wasn't updated after carbs update"
        )
    }
    
    func testClearButtonShouldClearForm() throws {
        // given
        let tablesQuery = app.tables
        let fatsInput = tablesQuery.textFields["tłuszcze"]
        let proteinsInput = tablesQuery.textFields["białka"]
        let carbsInput = tablesQuery.textFields["węglowodany"]
        let clearButton = app.buttons["Wyczyść"]
        
        XCTAssertEqual(fatsInput.value as! String, "tłuszcze", "Fats input has incorret placeholder or doesn't display it at all")
        XCTAssertEqual(proteinsInput.value as! String, "białka", "Proteins input has incorret placeholder or doesn't display it at all")
        XCTAssertEqual(carbsInput.value as! String, "węglowodany", "Carbs input has incorret placeholder or doesn't display it at all")
        
        // when
        fatsInput.tap()
        fatsInput.typeText("10")
        proteinsInput.tap()
        proteinsInput.typeText("11")
        carbsInput.tap()
        carbsInput.typeText("12")
        

        // then
        XCTAssertEqual(fatsInput.value as! String, "10", "Fats wasn't set properly")
        XCTAssertEqual(proteinsInput.value as! String, "11", "Proteins wasn't set properly")
        XCTAssertEqual(carbsInput.value as! String, "12", "Carbs wasn't set properly")
        
        
        // when
        clearButton.tap()
        
        
        // then
        XCTAssertEqual(fatsInput.value as! String, "tłuszcze", "Fats input has incorret placeholder or doesn't display it at all")
        XCTAssertEqual(proteinsInput.value as! String, "białka", "Proteins input has incorret placeholder or doesn't display it at all")
        XCTAssertEqual(carbsInput.value as! String, "węglowodany", "Carbs input has incorret placeholder or doesn't display it at all")
    }
    
    func testSaveButtonShouldBeDisabledIfPropertierAreNotProvided() throws {
        // given
        let tablesQuery = app.tables
        let fatsInput = tablesQuery.textFields["tłuszcze"]
        let proteinsInput = tablesQuery.textFields["białka"]
        let carbsInput = tablesQuery.textFields["węglowodany"]
        let saveButton = app.buttons["Zapisz"]
        
        // expect
        XCTAssertFalse(saveButton.isEnabled)
        
        // when
        fatsInput.tap()
        fatsInput.typeText("10")
        proteinsInput.tap()
        proteinsInput.typeText("11")
        carbsInput.tap()
        carbsInput.typeText("12")
        
        // then
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    func testItShouldSaveMeal() throws {
        // given
        let tablesQuery = app.tables
        let mealTabButton = app.tabBars["Tab Bar"].buttons["Dania"]
        let fatsInput = tablesQuery.textFields["tłuszcze"]
        let proteinsInput = tablesQuery.textFields["białka"]
        let carbsInput = tablesQuery.textFields["węglowodany"]
        let saveButton = app.buttons["Zapisz"]
        let nameInput = app.textFields["nazwa"]
        let cancelButton = app.buttons["Anuluj"]
        let confirmButton = app.buttons["Potwierdź"]
        let name = Date.now.formatted(date: .numeric, time: .shortened)
        
        // when
        fatsInput.tap()
        fatsInput.typeText("10")
        proteinsInput.tap()
        proteinsInput.typeText("11")
        carbsInput.tap()
        carbsInput.typeText("12")
        saveButton.tap()
        
        // then
        XCTAssertTrue(nameInput.waitForExistence(timeout: 0.1), "Name input is not displayed")
        
        // when
        cancelButton.tap()
        
        // then
        XCTAssertFalse(nameInput.waitForExistence(timeout: 0.1), "Name input is not displayed")
        
        
        // when
        saveButton.tap()
        nameInput.tap()
        nameInput.typeText(name)
        confirmButton.tap()
        
        XCTAssertTrue(mealTabButton.isHittable, "Meal tab button is not hittable (it might be covered by another item)")
        mealTabButton.tap()
        
        // then
        XCTAssertTrue(app.staticTexts[name].waitForExistence(timeout: 0.1), "Meal was not saved or it is not displayed on the list")
    }

}
