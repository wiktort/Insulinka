//
//  InsulinCalculatorModelTests.swift
//  InsulinkaTests
//
//  Created by Wiktor Tumiński on 16/01/2022.
//

import XCTest
@testable import Insulinka

class InsulinCalculatorModelTests: XCTestCase {
    var calculatorEngine: InsulinCalculatorModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        calculatorEngine = InsulinCalculatorModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculatorEngine = nil
        try super.tearDownWithError()
    }

    func testInsulinDosePer100GShouldBeCalculated() throws {
        //given
        let expectedInsulinDosePer100G: Float32 = 3.46
        
        //when
        calculatorEngine.fats = 10.00
        calculatorEngine.proteins = 12.00
        calculatorEngine.carbs = 25.00

        //then
        XCTAssertEqual(calculatorEngine.insulinDosePer100G, expectedInsulinDosePer100G)
    }
    
    
    func testInsulinDosePerMealShouldBeCalculated() throws {
        //given
        let expectedInsulinDosePerMeal: Float32 = 9.03
        
        //when
        calculatorEngine.fats = 8.00
        calculatorEngine.proteins = 14.00
        calculatorEngine.carbs = 28.00
        
        //then
        XCTAssertEqual(calculatorEngine.insulinDosePerMeal, 0.00)
        
        // when
        calculatorEngine.mealWeightInGrams = 250.00
        
        //then
        XCTAssertEqual(calculatorEngine.insulinDosePerMeal, expectedInsulinDosePerMeal)
    }
    
    func testHasAllPropertiesShouldCheckIfAllPropertiesAreProvided() throws {
        // all properties should be nil at the beginning
        XCTAssertEqual(calculatorEngine.fats , nil)
        XCTAssertEqual(calculatorEngine.proteins , nil)
        XCTAssertEqual(calculatorEngine.carbs , nil)
        
        // then
        XCTAssertFalse(calculatorEngine.hasAllProperties)
        
        // when
        calculatorEngine.fats = 10.00
        
        // then
        XCTAssertFalse(calculatorEngine.hasAllProperties)
        
        // when
        calculatorEngine.proteins = 10.00
        
        // then
        XCTAssertFalse(calculatorEngine.hasAllProperties)
        
        // when
        calculatorEngine.carbs = 10.00
        
        // then
        XCTAssertTrue(calculatorEngine.hasAllProperties)
        
        // when
        calculatorEngine.fats = nil
        calculatorEngine.proteins = nil
        
        // then
        XCTAssertFalse(calculatorEngine.hasAllProperties)
    }
}
