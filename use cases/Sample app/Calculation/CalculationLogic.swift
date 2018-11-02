//
//  CalculationLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/29/18.
//  Copyright © 2018 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

/**
 Type of calculation to do with user-inputted operands.
 */
enum CalculationType: Int {
    case addition = 0
    case subtraction
    case multiplication
    case division
}

struct CalculationLogic: Logic {

    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .calculate(let operand1, let operand2, let calculationType):
            print("[Action] .calculate: operand1 = \(operand1), operand2 = \(operand2), calculationType = \(calculationType)")
            var calculation = Calculation(operand1: operand1, operand2: operand2, calculationType: calculationType, result: nil)
            calculation.result = self.result(from: calculation)
            self.appendCalculationHistory(with: calculation, state: state)
            break
        case .goBackCalculationHistory():
            self.stepBackInCalculationHistory(with: state)
            break
        case .goForwardCalculationHistory():
            self.stepForwardInCalculationHistory(with: state)
            break
        default:
            break
        }
    }

    private func appendCalculationHistory(with calculation: Calculation, state: AppState) {
        // first, wipe out any unneeded 'future' calculations
        self.removeUnusedFutureHistory(with: state)

        state.currentCalculation = calculation
        state.calculations.history.append(calculation)
        state.calculations.currentIndex = state.calculations.history.count - 1
        self.updateCanGoBackOrForward(with: state)
    }
    
    private func removeUnusedFutureHistory(with state: AppState) {
        if let historyCurrentIndex = state.calculations.currentIndex {
            let totalNumberOfHistoryCalculations = state.calculations.history.count
            if historyCurrentIndex < (totalNumberOfHistoryCalculations - 1) {
                let subrangeToRemove = (historyCurrentIndex+1)..<totalNumberOfHistoryCalculations
                state.calculations.history.removeSubrange(subrangeToRemove)
            }
        }
    }
    
    /**
     Performs the arithmetic calculation represented by the given Calculation object.
     - parameter calculation: The object containing the calculation to be performed.
     - returns: The calculation result, as a Float.
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
     Move one step backward in the calculation history (if possible).
     - parameter state: An AppState object with the calculation history to be evaluated and updated.
     - returns: Nothing.  Directly modifies the given AppState object instead.
     */
    private func stepBackInCalculationHistory(with state: AppState) {
        if let currentIndex = state.calculations.currentIndex {
            let newIndex = max(currentIndex-1, 0)   // sanity check
            state.calculations.currentIndex = newIndex
            state.currentCalculation = state.calculations.history[newIndex]
            self.updateCanGoBackOrForward(with: state)
        }
    }

    /**
     Move one step forward in the calculation history (if possible).
     - parameter state: An AppState object with the calculation history to be evaluated and updated.
     - returns: Nothing.  Directly modifies the given AppState object instead.
     */
    private func stepForwardInCalculationHistory(with state: AppState) {
        if let currentIndex = state.calculations.currentIndex {
            let maxIndex = state.calculations.history.count - 1
            let newIndex = min(currentIndex+1, maxIndex)
            state.calculations.currentIndex = newIndex
            state.currentCalculation = state.calculations.history[newIndex]
            self.updateCanGoBackOrForward(with: state)
        }
    }
    
    /**
     Update whether it's possible to step back or forward in the calculation history from the current index.
     - parameter state: An AppState object with the calculation history to be evaluated and updated.
     - returns: Nothing.  Directly modifies the given AppState object instead.
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
    
    // TODO: add accessor for 'currentCalculation', derived from history
    
    
}
