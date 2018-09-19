//
//  Actions.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2018 Ron Diamond. All rights reserved.
//

/**
 Single Responsibility (SRP):
 This class implements the enum containing all possible Actions (with optional arguments) that can be passed in to the business logic for processing.
 */

import Foundation
import SwiftyJSON

/**
 Used to specify the type of command being issued to the various Logic modules, via LogicController.sharedInstance.performAction(...).
 NOTE: Actions are executed on the Main thread, via one or more Logic modules.
 Any expensive action logic should be performed asynchronously (on a background thread), and a separate 'store results' action performed, which would in turn mutate the appState itself on the main thread.
 */
enum Action {
    case null
    
    // MARK: Math Calculations
    case mathCalculation(operand1: Float, operand2: Float, calculationType: CalculationType)
    
    // MARK: Foo Service
    case fooServiceRequest()
    case fooServiceResponse(json: JSON)
}
