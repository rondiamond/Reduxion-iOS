//
//  AnalyticsLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 1/10/23.
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE file.
//

import Foundation

/**
 Single Responsibility (SRP):

 This struct implements sample Analytics logic, which calls some desired combination of analytics providers (depending, in this case, on the type of user action).

 Note that ALL functionality for the Analytics use case is handled here, in one place (rather than in an arbitrary number of views or other instances of business logic).
 */

/**
 Dummy values for Analytics provider platforms.

 In this example:
 - AdoboExperience logs ONLY when the user does a stock symbol lookup.
 - Convivial is inactive.
 - HooliEverywhere logs ONLY application lifecycle events.
 - NewRelish logs ALL actions the user performs.
 */
enum AnalyticsProvider: String {
    case AdoboExperience    = "AdoboExperience"
    case Convivial          = "Convivial"
    case HooliEverywhere    = "HooliEverywhere"
    case NewRelish          = "NewRelish"
}

/**
 Determines (e.g., for privacy purposes) which Analytics providers are actively logging app activity.
 */
let activeAnalyticsProviders: [AnalyticsProvider] = [
    AnalyticsProvider.AdoboExperience,
//    AnalyticsProvider.Convivial,      // inactive
    AnalyticsProvider.HooliEverywhere,
    AnalyticsProvider.NewRelish,
]

struct AnalyticsLogic: Logic {
    
    var service: Service?
    
    func performLogic(state: inout AppState, action: Action) {

        let analyticsPayload: String
        
        switch action {
            
            
            // ----------------------------------------------------------------------
            //                     Application Lifecycle
            // ----------------------------------------------------------------------

        case .applicationLaunched:
            print("['Analytics' use case demo - mock analytics providers logged below]\n")
            analyticsPayload = "application.launch"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)
            
        case .applicationResigning:
            analyticsPayload = "application.resign"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)

        case .applicationBackgrounded:
            analyticsPayload = "application.background"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)

        case .applicationForegrounding:
            analyticsPayload = "application.foreground"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)

        case .applicationActivated:
            analyticsPayload = "application.active"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)

        case .applicationTerminating:
            analyticsPayload = "application.terminate"
            logAnalytics(provider: .HooliEverywhere, payloadString: analyticsPayload)

            
            // ----------------------------------------------------------------------
            //                            Stock Quotes
            // ----------------------------------------------------------------------

        case .stockQuoteRequest(let symbol):
            analyticsPayload = "stock-quote.request.symbol: \(symbol)"
            logAnalytics(provider: .NewRelish, payloadString: analyticsPayload)
            logAnalytics(provider: .AdoboExperience, payloadString: analyticsPayload)

        case .stockQuoteResponse:
            // in this example, this action isn't logged
            return

            
            // ----------------------------------------------------------------------
            //                          History Navigation
            // ----------------------------------------------------------------------

        case .historyGoBack:
            analyticsPayload = "history.navigate.back"
            logAnalytics(provider: .NewRelish, payloadString: analyticsPayload)

        case .historyGoForward:
            analyticsPayload = "history.navigate.forward"
            logAnalytics(provider: .NewRelish, payloadString: analyticsPayload)

        case .historyClear:
            analyticsPayload = "history.clear"
            logAnalytics(provider: .NewRelish, payloadString: analyticsPayload)

            // ----------------------------------------------------------------------

        default:
            break
        }
        
        logAnalyticsEndOfEvent()
    }
    
    /*
     For demo purposes, 'analytics' calls print to the console (instead of making an actual service call).
     */
    func logAnalytics(provider: AnalyticsProvider, payloadString: String) {
        guard activeAnalyticsProviders.contains(provider) else {
            // provider isn't active, so ignore
            return
        }
        let analyticsProviderName = provider.rawValue
        print("\(analyticsProviderName) analytics: '\(payloadString)'")
    }
    
    func logAnalyticsEndOfEvent() {
        print("-------------")
    }

}
