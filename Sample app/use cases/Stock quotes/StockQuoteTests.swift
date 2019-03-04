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
    let stockSymbols = [
        "aapl", "goog", "nflx", "sbux", "tgt"
    ]
    var currentStockSymbol: String? = nil
    var stockResultInfo: DataModel.StockInfo? = nil

    
    override func setUp() {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        currentServicesType = .mock
        _ = UseCaseFactory.shared     // initialize
        LogicCoordinator.subscribe(self, updateWithCurrentAppState: false)
        LogicCoordinator.performAction(.clearHistory)
    }

    override func tearDown() {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        LogicCoordinator.unsubscribe(self)
    }

    func testStockLookup() {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
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
        LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
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
            if (self.expectation != nil) {
                print("self.expectation!.fulfill()")
                self.expectation!.fulfill()
            }
        default:
            break
        }
    }
    
}
