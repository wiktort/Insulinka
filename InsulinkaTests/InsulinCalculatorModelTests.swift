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

    

}
