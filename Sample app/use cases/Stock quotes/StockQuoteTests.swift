//
//  Reduxion_iOSTests.swift
//  Reduxion-iOSTests
//
//  Created by Ron Diamond on 8/25/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Quick
import Nimble
@testable import ReduxionIOS

class StockQuoteSpec: QuickSpec, AppStateSubscriber {
    var appStateSubscriberIdentifier: String = ""
    
    let stockSymbols = [
        "aapl", "goog", "nflx", "sbux", "tgt"
    ]
    var currentStockSymbol: String? = nil
    var stockResultInfo: StockInfo? = nil

    
    // MARK: - Setup

    override func spec() {
        beforeSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** beforeSuite **")
            
            let currentServicesType: ServicesType = .mock
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
                    let stockSymbol = stockSymbols.first!
                    LogicCoordinator.performAction(.stockQuoteServiceRequest(symbol: stockSymbol))
                    
                    // make sure result meets basic sanity checking
                    
                    expect(self.stockResultInfo).toEventually(!beNil())
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
//                        LogicCoordinator.performAction(.stockQuoteServiceRequest(symbol: symbol))
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
        }


        describe("Stock lookups") {
            context("when do n # of lookups") {
                it("then expect history count = the same number") {
                    try! something()
                    expect(some.state) == someother.state
                }
            }
        }
        
        describe("Stock history") {
            context("when do 1 lookup") {
                it("then expect no back or forward") {
                    // clear history
                    
                    try! something()
                    expect(some.state) == someother.state
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

                    try! something()
                    expect(some.state) == someother.state
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

        
        
        
        
    
    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        print("... mostRecentAction = \(mostRecentAction)")
        switch mostRecentAction {
        case .stockQuoteServiceResponse(_):
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
