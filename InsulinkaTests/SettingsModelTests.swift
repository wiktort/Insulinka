//
//  SettingsModelTests.swift
//  InsulinkaTest
//
//  Created by Wiktor Tumiński on 16/01/2022.
//

import XCTest
@testable import Insulinka

class SettingModelTests: XCTestCase {
    let settings =  SettingsModel.shared
    let errorBoundary = ErrorBoundary.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // clean up
        settings.setDefaultCarbohydrateRatio()
        settings.userName = "userName"
        errorBoundary.clearError()
        
        try super.tearDownWithError()
    }
    
    func testSettingsModelShouldUpdateUserName() throws {
        // given
        let oldUserName = settings.userName
        let newUserName = "newTestUserName"
        
        // when
        settings.userName = newUserName

        // then
        XCTAssertNotEqual(oldUserName, newUserName, "New and old userNames are the same")
        XCTAssertEqual(settings.userName, newUserName, "New userName wasn't set")
    }
    
    func testSettingsModelShouldCheckCarbohydrateRatioBeforeUpdating() throws {
        // when
        settings.carbohydrateRatio = nil
        
        // then
        XCTAssertEqual(errorBoundary.error, ErrorType.invalidCarbohydrateRatio, "Proper error wasn't risen")
    }
    
    func testSettingsModelShouldCleanErrorAfterUpdatingCarbohydrateRatio() throws {
        // given
        settings.carbohydrateRatio = nil
        
        // when
        settings.carbohydrateRatio = 10.00
        
        // then
        XCTAssertNotEqual(errorBoundary.error, ErrorType.invalidCarbohydrateRatio, "invalidCarbohydrateRatio error wasn't cleared")
    }
    
    func testSettingModelShouldUpdateCarbohydrateRatioBefore() throws {
        // given
        let newCarbohydrateRatio: Float32 = 10.00
        
        //when
        settings.carbohydrateRatio = newCarbohydrateRatio
        
        // then
        XCTAssertNotEqual(errorBoundary.error, ErrorType.invalidCarbohydrateRatio, "Setting proper value has risen an error")
        XCTAssertEqual(settings.carbohydrateRatio, newCarbohydrateRatio, "Proper value wasn't set")
    }
    
    func testSettingsModelShouldResetCarbohydrateRatio() throws {
        // given
        settings.carbohydrateRatio = 10.0
        
        // when
        settings.setDefaultCarbohydrateRatio()
        
        // then
        XCTAssertEqual(settings.carbohydrateRatio, DEFAULT_CARBOHYDRATE_RATIO, "Resetting CarbohydrateRatio didn't work")
    }
    
}
