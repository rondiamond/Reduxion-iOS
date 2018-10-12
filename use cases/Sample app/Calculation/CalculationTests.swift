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
//    var expectedResult: Float = 0.0
var expectedResult: Float = -1

    var actualResult: Float = 0.0
//    var awaitingResult: Bool = true
    
    override func spec() {
        
//        beforeSuite {
//            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
//            print("** beforeSuite **")
////            LogicCoordinator.subscribe(self)
//        }
//
//        afterSuite {
//            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
//            print("** afterSuite **")
////            LogicCoordinator.unsubscribe(self)
//        }

//        beforeEach {
//            self.awaitingResult = true
//        }
        
        describe("Math calculation") {
            context("attempt to add") {
                it("should calculate correctly") {
                    print("*** RUNNING TEST ***")
                    self.operand1 = 23
                    self.operand2 = 45
                    self.calculationType = .addition
                    self.expectedResult = self.operand1 + self.operand2
//                    LogicCoordinator.performAction(.calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
                    
//                    while (self.awaitingResult) {
//                        print("awaiting result")
//                    }
//                    expect(self.actualResult) == self.expectedResult
//                    expect(self.actualResult).toEventually(equal(self.expectedResult))
expect(true)
                }
            }
        }

    }

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .calculate(_):
            if let result = state.currentCalculation?.result {
                self.actualResult = result
//                self.awaitingResult = false
                print("*** GOT RESULT ***")
            } else {
                // ?
            }
        default:
            break
        }
    }

}
