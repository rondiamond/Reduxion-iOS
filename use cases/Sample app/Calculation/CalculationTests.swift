//
//  Reduxion_iOSTests.swift
//  Reduxion-iOSTests
//
//  Created by Ron Diamond on 8/25/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//

import Quick
import Nimble

class CalculationSpec: QuickSpec, AppStateSubscriber {
    
    var appStateSubscriberIdentifier: String = ""

    var operand1: Float = 0.0
    var operand2: Float = 0.0
    var calculationType: CalculationType = .addition
    var expectedResult: Float = 0.0

    var actualResult: Float = 0.0
    
    override func spec() {
        
        beforeSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** beforeSuite **")
            let calculationLogic = CalculationLogic()
            LogicCoordinator.add(logic: calculationLogic)
            LogicCoordinator.subscribe(self, updateWithCurrentAppState: false)
        }

        afterSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** afterSuite **")
            LogicCoordinator.unsubscribe(self)
        }

        describe("Math calculation") {
            context("attempt to add") {
                it("should calculate correctly") {
                    self.operand1 = 23
                    self.operand2 = 45
                    self.calculationType = .addition
                    self.expectedResult = self.operand1 + self.operand2
                    LogicCoordinator.performAction(.calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
                    expect(self.actualResult).toEventually(equal(self.expectedResult))
                }
            }
            
            context("attempt to multiply") {
                it("should calculate correctly") {
                    self.operand1 = 23
                    self.operand2 = 45
                    self.calculationType = .multiplication
                    self.expectedResult = self.operand1 * self.operand2
                    LogicCoordinator.performAction(.calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
                    expect(self.actualResult).toEventually(equal(self.expectedResult))
                }
            }
        }

    }

    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        print("... mostRecentAction = \(mostRecentAction)")
        switch mostRecentAction {
        case .calculate(_):
            if let result = state.currentCalculation?.result {
                print("... result = \(result)")
                self.actualResult = result
            }
        default:
            break
        }
    }

}
