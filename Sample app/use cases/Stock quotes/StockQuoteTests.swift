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
        self.expectation = expectation(description: "Expected information from stock lookup")
        let stockSymbol = self.stockSymbols.first!
        self.appStateUpdatedCompletionBlock = {
            (state: AppState) in
            XCTAssert(state.dataModel.stocksHistory.history.count == 1, "Expected an entry in the stock lookup history")
        }
        LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
        waitForExpectations(timeout: expectationWaitTimeInSeconds) { error in
            print("... error = \(String(describing: error))")
        }
    }
        
    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        print("... mostRecentAction = \(mostRecentAction)")
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




/*
 //
 //  Reduxion_iOSTests.swift
 //  Reduxion-iOSTests
 //
 //  Created by Ron Diamond on 8/25/18.
 //  Copyright © 2018-2019 Ron Diamond.
 //  Licensed per the LICENSE.txt file.
 //
 
 import XCTest
 @testable import ReduxionIOS
 
 
 class StockQuoteSpec: XCTest, AppStateSubscriber {
 var appStateSubscriberIdentifier: String = ""
 
 let stockSymbols = [
 "aapl", "goog", "nflx", "sbux", "tgt"
 ]
 var currentStockSymbol: String? = nil
 var stockResultInfo: DataModel.StockInfo? = nil
 
 
 // MARK: - Setup
 
 override func spec() {
 beforeSuite {
 print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
 print("** beforeSuite **")
 
 currentServicesType = .mock
 _ = UseCaseFactory.shared     // initialize
 LogicCoordinator.subscribe(self, updateWithCurrentAppState: false)
 }
 
 beforeEach {
 print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
 print("** beforeEach **")
 
 // clear history
 
 self.currentStockSymbol = nil
 }
 
 afterEach {
 print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
 print("** afterEach **")
 
 }
 
 afterSuite {
 print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
 print("** afterSuite **")
 
 LogicCoordinator.unsubscribe(self)
 }
 
 
 // MARK: - Tests
 
 describe("Stocks") {
 context("attempt to look up") {
 it("should get some stock information") {
 // pick a stock
 let stockSymbol = self.stockSymbols.first!
 LogicCoordinator.performAction(.stockQuoteRequest(symbol: stockSymbol))
 
 // make sure result meets basic sanity checking
 
 //                    expect(self.stockResultInfo).toEventually(!beNil())
 //                    expect(self.stockResultInfo).toEventually(!beNil())
 //expect(self.stockResultInfo
 //                    self.stockResultInfo.symbol
 
 
 
 
 // symbol name >= 1 character
 
 // Note: If using mock data for the service layer, it's expected that the values may not match that of the original stock symbol.
 
 
 
 }
 }
 }
 
 describe("Stock quotes") {
 context("attempt to fetch data") {
 it("should yield current stock data") {
 //                    for stockWithExpectedValues in self.stocksWithExpectedValues {
 //                        let symbol = stockWithExpectedValues.symbol
 //                        LogicCoordinator.performAction(.stockQuoteRequest(symbol: symbol))
 //
 //                        let expectedCompanyNamePartial = stockWithExpectedValues.expectedCompanyNamePartial
 //                        let expectedCompanySectorPartial = stockWithExpectedValues.expectedCompanySectorPartial
 //                        let expectedPrice = stockWithExpectedValues.expectedPrice
 //                        let expectedPriceMinimum = self.stockExpectedPriceRangeMinimum * expectedPrice
 //                        let expectedPriceMaximum = self.stockExpectedPriceRangeMaximum * expectedPrice
 //
 //                        expect(self.stockCurrentPrice).toEventually(beGreaterThan(expectedPriceMinimum))
 //                        expect(self.stockCurrentPrice).toEventually(beLessThan(expectedPriceMaximum))
 //                        expect(stockWithExpectedValues.expectedCompanyNamePartial.contains(<#T##element: Character##Character#>)
 //
 }
 
 
 
 }
 }
 
 
 describe("Stock lookups") {
 context("when do n # of lookups") {
 it("then expect history count = the same number") {
 print("foobar")
 }
 }
 }
 
 describe("Stock history") {
 context("when do 1 lookup") {
 it("then expect no back or forward") {
 // clear history
 
 }
 }
 }
 
 describe("Stock history") {
 context("when do 2 lookups") {
 it("then expect back, but no forward") {
 // clear history
 
 
 }
 }
 }
 
 describe("Stock history") {
 context("when do 3 lookups, then step back") {
 it("then expect both Back and Forward enabled") {
 // clear history
 
 
 }
 }
 }
 
 describe("given") {
 context("when") {
 it("then") {
 // clear history
 
 //                    try! something()
 //                    expect(some.state) == someother.state
 }
 }
 }
 
 
 
 
 
 
 /*
 describe("Math calculation") {
 context("attempt to add") {
 it("should calculate correctly") {
 self.operand1 = 23
 self.operand2 = 45
 self.calculationType = .addition
 self.expectedResult = self.operand1 + self.operand2
 LogicCoordinator.performAction(.calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
 expect(self.actualResult).toEventually(equal(self.expectedResult))
 }
 }
 
 context("attempt to multiply") {
 it("should calculate correctly") {
 self.operand1 = 23
 self.operand2 = 45
 self.calculationType = .multiplication
 self.expectedResult = self.operand1 * self.operand2
 LogicCoordinator.performAction(.calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
 expect(self.actualResult).toEventually(equal(self.expectedResult))
 }
 }
 }
 */
 
 }
 
 
 
 
 
 // MARK: - AppState
 
 func update(_ state: AppState, mostRecentAction: Action) {
 print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
 print("... mostRecentAction = \(mostRecentAction)")
 switch mostRecentAction {
 case .stockQuoteResponse(_):
 self.stockResultInfo = state.dataModel.stocksHistory.currentStock
 
 
 
 
 //        case .calculate(_):
 //            if let result = state.currentCalculation?.result {
 //                print("... result = \(result)")
 //                self.actualResult = result
 //            }
 default:
 break
 }
 }
 
 }

 */
