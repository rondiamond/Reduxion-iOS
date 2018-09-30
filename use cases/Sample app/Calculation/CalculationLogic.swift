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
            var calculation = Calculation(operand1: operand1, operand2: operand2, calculationType: calculationType, result: nil)
            calculation.result = self.result(from: calculation)
//            state.currentCalculation = calculation
//            state.calculations.history.append(calculation)
//            state.calculations.currentIndex = state.calculations.history.count - 1
//            self.updateCanGoBackOrForward(with: state)
            self.updateCalculationHistory(with: calculation, state: state)
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

    func updateCalculationHistory(with calculation: Calculation, state: AppState) {
//        print("[Action] .performCalculation: operand1 = \(operand1), operand2 = \(operand2), calculationType = \(calculationType)")
//        let result = self.performCalculation(operand1: operand1, operand2: operand2, calculationType: calculationType)
        
//        let calculation = Calculation(operand1: operand1, operand2: operand2, calculationType: calculationType, result: result)
        state.currentCalculation = calculation
        
        // wipe out any unneeded 'future' calculations first, before appending calculation to history
        if let historyCurrentIndex = state.calculations.currentIndex {
            let totalNumberOfHistoryCalculations = state.calculations.history.count
            if historyCurrentIndex < (totalNumberOfHistoryCalculations - 1) {
                let subrangeToRemove = historyCurrentIndex..<totalNumberOfHistoryCalculations
                state.calculations.history.removeSubrange(subrangeToRemove)
            }
        }
        
        state.calculations.history.append(calculation)
        state.calculations.currentIndex = state.calculations.history.count - 1
        self.updateCanGoBackOrForward(with: state)
    }
    
//    func removeUnusedFutureHistory(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    
    
    
    /**
     [synopsis]
     - parameter foo: [explanation]
     - returns: [explanation]
     */
    private func result(from calculation: Calculation) -> Float {
        let result: Float
        switch calculation.calculationType {
        case .addition:
            result = calculation.operand1 + calculation.operand2
            break
        case .subtraction:
            result = calculation.operand1 - calculation.operand2
            break
        case .multiplication:
            result = calculation.operand1 * calculation.operand2
            break
        case .division:
            result = calculation.operand1 / calculation.operand2
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
        if let historyCurrentIndex = state.calculations.currentIndex {
            let canGoForward = historyCurrentIndex < (state.calculations.history.count - 1)
            state.calculations.canGoForward = canGoForward
            let canGoBack = (historyCurrentIndex > 0)
            state.calculations.canGoBack = canGoBack
        }
    }
    
    
    
    // TODO: update current calculation (from index)
    
    
    
}
