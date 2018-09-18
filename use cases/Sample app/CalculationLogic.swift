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
        case .mathRequest (let operand1, let operand2, let calculationType):
            // TODO: do something useful
            _ = operand1
            _ = operand2
            _ = calculationType
            // ...
            break

        case .mathResponse (let solution):
            // TODO: parse response, and process data
            _ = solution
            break

        default:
            break
        }
    }
    
}
