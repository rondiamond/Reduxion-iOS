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

    func performCalculation(operand1: Float, operand2: Float, calculationType: CalculationType) -> Float {
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
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .mathRequest (let operand1, let operand2, let calculationType):
            state.currentCalculation.operand1 = operand1
            state.currentCalculation.operand2 = operand2
            state.currentCalculation.calculationType = calculationType
            let result = self.performCalculation(operand1: operand1, operand2: operand2, calculationType: calculationType)
            state.currentCalculation.result = result
            break

        default:
            break
        }
    }
    
}
