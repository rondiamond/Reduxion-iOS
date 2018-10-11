//
//  Reduxion_iOSTests.swift
//  Reduxion-iOSTests
//
//  Created by Ron Diamond on 8/25/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//

//import XCTest
//@testable import Reduxion_iOS
/*
import Quick
import Nimble

class Reduxion_iOSTests: XCTestCase {

    var operand1: Float
    var operand2: Float
    var calculationType: CalculationType
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculation() {
        operand1 = 23
        operand2 = 45
        calculationType = .addition
        expectedResult = operand1 + operand2

        LogicCoordinator.performAction(.calculate(operand1: operand1, operand2: operand2, calculationType: calculationType))
        
        
        
    }
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
 */

import Quick
import Nimble
//@testable import Reduxion-iOS

class CalculationSpec: QuickSpec, AppStateSubscriber {
    var appStateSubscriberIdentifier: String = ""

    var operand1: Float = 0.0
    var operand2: Float = 0.0
    var calculationType: CalculationType = .addition
    var expectedResult: Float = 0.0
    var actualResult: Float = 0.0

    override func spec() {
        
        beforeEach {
        }
        
        describe("Math calculation") {
            context("attempt to add") {
                it("should calculate correctly") {
                    self.operand1 = 23
                    self.operand2 = 45
                    self.calculationType = .addition
                    self.expectedResult = self.operand1 + self.operand2
                    expect(self.actualResult) == self.expectedResult
                }
            }
        }

        // MARK: - AppState

        func update(_ state: AppState, mostRecentAction: Action) {
            switch mostRecentAction {
            case .calculate(_):
                if let result = state.currentCalculation?.result {
                    actualResult = result
                } else {
                    // ?
                }
            default:
                break
            }
        }

    }
}
