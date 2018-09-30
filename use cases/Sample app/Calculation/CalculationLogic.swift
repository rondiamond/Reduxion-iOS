//
//  CalculationLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/29/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//

import Foundation

/**
 Type of calculation to do with user-inputted operands.
 */
enum CalculationType {
    case addition
    case subtraction
    case multiplication
    case division
}

struct CalculationLogic: Logic {

    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .performCalculation(let operand1, let operand2, let calculationType):
            print("[Action] .performCalculation: operand1 = \(operand1), operand2 = \(operand2), calculationType = \(calculationType)")
            var calculation = Calculation()
            calculation.operand1 = operand1
            calculation.operand2 = operand2
            calculation.calculationType = calculationType
            let result = self.performCalculation(operand1: operand1, operand2: operand2, calculationType: calculationType)
            calculation.result = result
            state.currentCalculation = calculation
            state.calculations.history.append(state.currentCalculation)
            state.calculations.currentIndex = state.calculations.history.count - 1
            break
        case .goBackCalculationHistory():
            self.goBackCalculationHistory(with: state)
            break
        case .goForwardCalculationHistory():
            self.goForwardCalculationHistory(with: state)
            break
        default:
            break
        }
    }

    /**
     [synopsis]
     - parameter foo: [explanation]
     - returns: [explanation]
     */
    private func performCalculation(operand1: Float, operand2: Float, calculationType: CalculationType) -> Float {
        let result: Float
        switch calculationType {
        case .addition:
            result = operand1 + operand2
            break
        case .subtraction:
            result = operand1 - operand2
            break
        case .multiplication:
            result = operand1 * operand2
            break
        case .division:
            result = operand1 / operand2
            break
        }
        return result
    }
    
    /**
     [synopsis]
     */
    private func goBackCalculationHistory(with state: AppState) {
        if let currentIndex = state.calculations.currentIndex {
            let newIndex = max(currentIndex-1, 0)   // sanity check
            state.calculations.currentIndex = newIndex
            self.updateCanGoBackOrForward(with: state)
        }
    }

    /**
     [synopsis]
     */
    private func goForwardCalculationHistory(with state: AppState) {
        // increment calculation history index (if we can)
// NOTE: there may be other 'future' states we now need to overwrite
        if let currentIndex = state.calculations.currentIndex {
let newIndex = max(currentIndex-1, 0)   // sanity check
            state.calculations.currentIndex = newIndex
            self.updateCanGoBackOrForward(with: state)
        }
    }

    /**
     [synopsis]
     */
    private func updateCanGoBackOrForward(with state: AppState) {
    
        // update CURRENT CALCULATION
        
        
        
    }
    
    
    
    // TODO: update current calculation (from index)
    
    
    
}
