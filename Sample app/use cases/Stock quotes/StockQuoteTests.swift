//
//  StockQuoteTests.swift
//  ReduxionIOSTests
//
//  Created by Ron Diamond on 3/3/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import XCTest

class StockQuoteTests: XCTestCase, AppStateSubscriber {
    var appStateSubscriberIdentifier: String = ""
    
    var expectation: XCTestExpectation?
    var expectationWaitTimeInSeconds = 10.0
    var appStateUpdatedCompletionBlock: ((AppState) -> Void)?
    var numberOfExpectedActionTypeUpdates = 0
    var actionTypeForExpectedNumberOfUpdates: Action?
    
    let stockSymbols = [
        "aapl", "goog", "nflx", "sbux", "tgt"
    ]
    var currentStockSymbol: String? = nil
    var stockResultInfo: DataModel.StockInfo? = nil

    
    override func setUp() {
        currentServicesType = .mock
        //currentServicesType = .real(.production)
        _ = UseCaseFactory.shared     // initialize
        LogicCoordinator.subscribe(self, updateWithCurrentAppState: false)
        LogicCoordinator.performAction(.clearHistory)
    }

    override func tearDown() {
        LogicCoordinator.unsubscribe(self)
    }

    func testStockLookup() {
        self.expectation = expectation(description: "Expected information from stock lookup")
        let stockSymbol = self.stockSymbols.first!
        self.appStateUpdatedCompletionBlock = {
            (state: AppState) in
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")

            // NOTE: the response may be from Mock (static) data
            XCTAssert(state.dataModel.stocksHistory.history.count == 1, "Expected an entry in the stock lookup history")
            XCTAssert(state.dataModel.stocksHistory.currentStock?.name?.count != 0, "Expected a name from the stock lookup")
            XCTAssert(state.dataModel.stocksHistory.currentStock?.previousClose != 0, "Expected the closing price to be non-zero")
        }
        self.numberOfExpectedActionTypeUpdates = 1
        LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
        waitForExpectations(timeout: expectationWaitTimeInSeconds) { error in
            print("... error = \(String(describing: error))")
        }
    }
    
    func testHistoryStatusForMultipleStockLookups() {
        self.actionTypeForExpectedNumberOfUpdates = Action.stockQuoteResponse
        self.numberOfExpectedActionTypeUpdates = stockSymbols.count
        self.expectation = expectation(description: "Expected correct history state after \(numberOfExpectedActionTypeUpdates) lookups")
        self.appStateUpdatedCompletionBlock = {
            (state: AppState) in
            XCTAssert(state.dataModel.stocksHistory.history.count == self.stockSymbols.count, "Expected correct number of stock history entries")
            XCTAssert(state.dataModel.stocksHistory.canGoBack == true, "Expected history back button to be enabled")
            XCTAssert(state.dataModel.stocksHistory.canGoBack == false, "Expected history forward button to be disabled")
            XCTAssert(state.dataModel.stocksHistory.enableClearHistory == true, "Expected history clear button to be enabled")
        }
        for stockSymbol in stockSymbols {
            LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
        }
        waitForExpectations(timeout: expectationWaitTimeInSeconds) { error in
            print("... error = \(String(describing: error))")
        }
    }

    func testHistoryStatusForMultipleStockLookupsAndNavigation() {
        self.actionTypeForExpectedNumberOfUpdates = Action.goBackInHistory
        self.numberOfExpectedActionTypeUpdates = 1      // i.e., the Back action
        self.expectation = expectation(description: "Expected correct history state after \(numberOfExpectedActionTypeUpdates) lookups")
        self.appStateUpdatedCompletionBlock = {
            (state: AppState) in
            XCTAssert(state.dataModel.stocksHistory.history.count == self.stockSymbols.count, "Expected correct number of stock history entries")
            XCTAssert(state.dataModel.stocksHistory.canGoBack == true, "Expected history back button to be enabled")
            XCTAssert(state.dataModel.stocksHistory.canGoForward == false, "Expected history forward button to be disabled")
            XCTAssert(state.dataModel.stocksHistory.enableClearHistory == true, "Expected history clear button to be enabled")
        }
        for stockSymbol in stockSymbols {
            LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
        }
        waitForExpectations(timeout: expectationWaitTimeInSeconds) { error in
            print("... error = \(String(describing: error))")
        }
    }

    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        switch mostRecentAction {
        case .stockQuoteResponse(_):
            self.stockResultInfo = state.dataModel.stocksHistory.currentStock
            if (self.appStateUpdatedCompletionBlock != nil) {
                self.appStateUpdatedCompletionBlock!(state)
            }
        default:
            break
        }
        
        
//        if case self.actionTypeForExpectedNumberOfUpdates(_) == mostRecentAction {
//
//        }
        
print("Action = \(mostRecentAction)")
        if (mostRecentAction == self.actionTypeForExpectedNumberOfUpdates!) {
            print("self.numberOfExpectedStateUpdates = \(self.numberOfExpectedActionTypeUpdates)")
            self.numberOfExpectedActionTypeUpdates -= 1
            if (self.numberOfExpectedActionTypeUpdates == 0) {
                if (self.expectation != nil) {
                    print("self.expectation!.fulfill()")
                    self.expectation!.fulfill()
                }
            }
        }
        
    }

    
}
