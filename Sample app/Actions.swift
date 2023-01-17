//
//  Actions.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE file.
//

/**
 Single Responsibility (SRP):
 This enum contains all possible Actions (with optional arguments) that can be passed in to the business logic for processing.
 */

import Foundation
import SwiftyJSON

/**
 Used to specify the type of command being issued to the various Logic modules, via LogicController.sharedInstance.performAction(...).
 
 NOTE: Actions are executed on the Main thread, via one or more Logic modules.
 Any expensive action logic should be performed asynchronously (on a background thread).
 A separate action for the results would be performed, and in turn mutate the appState itself on the main thread.
 */
enum Action: Equatable {
    case null
    
    // MARK: Application lifecycle events
    case applicationLaunched
    case applicationResigning
    case applicationBackgrounded
    case applicationForegrounding
    case applicationActivated
    case applicationTerminating
    
    // MARK: Stock quote service
    case stockQuoteRequest(symbol: String)
    case stockQuoteResponse(json: JSON, error: String?)

    // MARK: History navigation
    case historyGoBack
    case historyGoForward
    case historyClear
}
