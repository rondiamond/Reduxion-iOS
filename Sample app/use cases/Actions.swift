//
//  Actions.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
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
enum Action: Equatable {
    case null
    
    // MARK: Stock quote service
    case stockQuoteRequest(symbol: String)
    case stockQuoteResponse(json: JSON, error: String?)
    
    case goBackInHistory
    case goForwardInHistory
    case clearHistory
}
