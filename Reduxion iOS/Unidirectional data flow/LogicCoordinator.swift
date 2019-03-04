//
//  LogicCoordinator.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//
//  Based upon:
//  Redux-iOS - created by Armin Kroll on 12/12/2015.
//  https://github.com/armin/Redux-iOS/blob/8bf11d9e2495e1e7969d42ea266ec76b59472e1b/LICENSE
//

/**
 Single Responsibility (SRP):
 This class implements the LogicCoordinator object.  It:
 ... accepts Action requests from the rest of the application
 ... hands those actions off to each Logic unit for processing
 ... notifies Subscribers when the logic processing has finished
 */

import Foundation

// MARK: - Initialization

/**
 Instantiates the Logic Coordinator for the application.
 - parameter logicUnits: The logic units to be in the daisy chain.
 */
func initializeLogicCoordinator(logicUnits: [Logic]) {
    _ = LogicCoordinator.sharedInstance   // instantiate singleton
    LogicCoordinator.sharedInstance.logicUnits = logicUnits
}


// MARK: - Protocols

/**
 *  A 'logic' module is something that mutates an AppState object as needed, based on a given Action.
 */
protocol Logic {
    /**
     Protocol method for asking Logic modules to perform any relevant Action on the provided AppState struct.
     - parameter state:  AppState struct: encapsulates the entire state of the application
     - parameter action: Action enum: encapsulates the desired operation being requested, and optionally carries any relevant data (as an attributed enum value)
     Nothing is returned.  Instead, the logic (optionally) mutates the AppState object passed in (if the requested action was something relevant to what that business logic cared about).
     */
    func performLogic(state: inout AppState, action: Action)

    /**
     *  Utilized by logic modules which connect with a web service. (The logic module's reference to the Service must be injected, to support unit testing, mock data, etc.).
     */
    var service: Service? { get set }
}


// MARK: AppStateSubscriber

/**
 *  An AppStateSubscriber is an object that listens for changes to the AppState, and has the opportunity to react to different types of Actions.
 */
protocol AppStateSubscriber {
    /**
     AppStateSubscribers each have a unique identifier, so they can be compared.
     */
    var appStateSubscriberIdentifier: String { get set }
    
    /**
     Offers a logic module the opportunity to (optionally) mutate the AppState, based on the most recent type of Action.
     - parameter state:  Reference to the AppState to optionally be mutated.
     - parameter mostRecentAction:  The most recent Action executed by the business/service logic.  Allows the listener to determine what to do, if anything, based on the type of Action executed.
     */
    func update(_ state: AppState, mostRecentAction: Action)
}


// MARK: - Utility functions

/**
 Helper method to generate unique identifier.  Can be used as an attribute in comparing instances, to make them unique, identifiable, and able to be filtered.
 - returns: A newly-created unique identifier.
 */
private func generateUniqueIdentifier() -> String {
    let identifier = UUID().uuidString
    return identifier
}

/**
 Equatable for AppStateSubscribers. This will allow us to filter them.
 - parameter lhs: The first subscriber to be compared.
 - parameter rhs: The second subscriber to be compared.
 - returns: True if the subscribers have the different identifiers; False if they're the same.
 */
func !=(lhs: AppStateSubscriber, rhs: AppStateSubscriber) -> Bool {
    let isInequal = (lhs.appStateSubscriberIdentifier != rhs.appStateSubscriberIdentifier)
    return isInequal
}


// MARK: - LogicCoordinator

class LogicCoordinator {

    static let sharedInstance = LogicCoordinator.init()

    // overall state
    fileprivate var appState = AppState()
    fileprivate var appStateRecalled: Bool = false
    fileprivate var subscribers = [AppStateSubscriber]()

    // MARK: - Logic units
    fileprivate var stockQuoteLogic = StockQuoteLogic()
    
    
    // MARK: - Logic units (aka 'reducers')
    /**
     The daisy chain of composable business logic units
     Notes:
     - This business logic is the same regardless of whether we're using real or mock data.
     - The order of logic units in the daisy chain shouldn't matter.  If so, that's a code smell, and dependent operations should be handled differently.
     */
    fileprivate var logicUnits: [Logic] = []
    
    
    // MARK: - Data persistence
    
    func persistAppState() {
        AppState.persist(self.appState)
    }
    
    func recallAppState() {
        if (self.appStateRecalled) {
            print("Warning: AppState should only be recalled once at the beginning of the session")
            return
        }
        
        self.appState = AppState.recall()
        self.appStateRecalled = true
    }

    
    // MARK: - Convenience functions
    // Convenience functions for accessing the LogicCoordinator's sharedInstance.
    
    static func performAction(_ action: Action) {
        LogicCoordinator.sharedInstance.performAction(action)
    }

    static func subscribe(_ newSubscriber: AppStateSubscriber) {
        LogicCoordinator.sharedInstance.subscribe(newSubscriber)
    }
    
    static func subscribe(_ newSubscriber: AppStateSubscriber, updateWithCurrentAppState: Bool) {
        LogicCoordinator.sharedInstance.subscribe(newSubscriber, updateWithCurrentAppState: updateWithCurrentAppState)
    }
    
    static func unsubscribe(_ listener: AppStateSubscriber) {
        LogicCoordinator.sharedInstance.unsubscribe(listener)
    }

    
    // MARK: - Action

    /**
     Causes the LogicCoordinator to call all the individual logic modules, which each mutate relevant portions of the app state as needed.
     - parameter action: The Action to be submitted to the various logic modules (with optional data).
     NOTE: Logic is executed on the Main thread.  If the request is initiated from the main thread, then the logic (and the update:appState callback) will be executed synchronously.
     */
    private func performAction(_ action: Action) {
        // All actions *must* be performed on the same thread, in order to insure data consistency.
        if !Thread.current.isMainThread {
            DispatchQueue.main.async {
                self.performLogic(action)
            }
        } else {
            // if we're already on the Main thread, then do it synchronously
            self.performLogic(action)
        }
    }

    /**
      Logic execution, separated out from 'performAction', so it can be executed on the proper thread.
     - parameter action: The Action to be executed.
     */
    private func performLogic(_ action: Action) {
        // Note: Expensive action logic should be performed on a separate thread; and when ready with the results, should call another type of action specifically for the purpose of mutating the AppState.
        self.logicUnits.forEach({ $0.performLogic(state: &self.appState, action: action) })
        self.updateSubscribers(action)
    }
    

    // MARK: - Subscribers
    
    /**
     Wrapper method for 'subscribe(newSubscriber:updateWithCurrentAppState:', where updateWithCurrentAppState = True.
     - parameter newSubscriber: The new subscriber to be added.
     */
    private func subscribe(_ newSubscriber: AppStateSubscriber) {
        self.subscribe(newSubscriber, updateWithCurrentAppState: true)
    }
    
    /**
     Add the new Subscriber, which will then be notified after the processing of any subsequent 'performAction' call.
     - parameter newSubscriber:  The new subscriber to be added.
     - parameter updateWithCurrentAppState: Whether or not to immediately call back the 'update:state' method with the current AppState.
     */
    private func subscribe(_ newSubscriber: AppStateSubscriber, updateWithCurrentAppState: Bool) {
        for subscriber in self.subscribers {
            if newSubscriber.appStateSubscriberIdentifier == subscriber.appStateSubscriberIdentifier {
                // already subscribed
                return
            }
        }
        
        let identifier = generateUniqueIdentifier()
        var mutableListener = newSubscriber
        mutableListener.appStateSubscriberIdentifier = identifier
        self.subscribers.append(newSubscriber)
        
        if updateWithCurrentAppState {
            newSubscriber.update(self.appState, mostRecentAction: Action.null)  // ?
        }
    }

    /**
      Updates all subscribers of the resulting AppState of any 'performAction' call.
     */
    private func updateSubscribers(_ mostRecentAction: Action) {
        // Since observers include the View layer, this needs to be on the Main thread.
        let appStateReadOnly = self.appState
        self.subscribers.forEach { $0.update(appStateReadOnly, mostRecentAction: mostRecentAction) }
    }
    
    /**
     Removes the subscriber from being notified of the results of any subsequent 'performAction' call.
     - parameter listener: The subscriber to be removed.
     */
    private func unsubscribe(_ listener: AppStateSubscriber) {
        self.subscribers = self.subscribers.filter({ $0.appStateSubscriberIdentifier != listener.appStateSubscriberIdentifier })
    }
}
