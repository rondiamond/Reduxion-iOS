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
@testable import Reduxion-iOS

class StockQuoteSpec: QuickSpec, AppStateSubscriber {
    
    var appStateSubscriberIdentifier: String = ""
    
    /*
    var operand1: Float = 0.0
    var operand2: Float = 0.0
    var calculationType: CalculationType = .addition
    var expectedResult: Float = 0.0
    var actualResult: Float = 0.0
     */

    /// sanity check - used to verify that actual stock price reported back is in reasonable range relative to expected price
    let stockExpectedPriceRangeMinimum = 0.5
    let stockExpectedPriceRangeMaximum = 2.0

    
    struct StockQuoteTestData {
        let symbol: String
        let expectedPrice: Float
        let expectedCompanyNamePartial: String      // case insensitive
        let expectedCompanySectorPartial: String    // case insensitive
    }
    
    var stocksWithExpectedValues: [StockQuoteTestData] = [
        ("aapl", 170.00, "apple", "tech"),
        ("goog", 1100.00, "google", "tech"),
        ("nflx", 360.00, "netflix", "consumer"),
        ("sbux", 70.00, "starbucks", "consumer"),
        ("tgt", 70.00, "target", "consumer")
    ]
    
    var stockToTest: StockQuoteTestData
    var stockActualInfo: StockInfo       // result

    func expectedValuesFor(stockSymbol: String) -> StockQuoteTestData {
        expectedValuesForStock = self.stocksWithExpectedValues.filter { $0.symbol == stockSymbol }
    }
    
    override func spec() {
        beforeSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** beforeSuite **")
            initializeLogicCoordinator(currentServiceEnvironmentType)
            
            let stockQuoteLogic = StockQuoteLogic()
            LogicCoordinator.add(logic: stockQuoteLogic)
            LogicCoordinator.subscribe(self, updateWithCurrentAppState: false)
        }
        
        afterSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** afterSuite **")
            // TODO: remove Logic from LogicCoordinator ?
            LogicCoordinator.unsubscribe(self)
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

        describe("Stock quotes") {
            context("attempt to fetch data") {
                it("should yield current stock data") {
                    for stockWithExpectedValues in self.stocksWithExpectedValues {
                        let symbol = stockWithExpectedValues.symbol
                        LogicCoordinator.performAction(.stockQuoteServiceRequest(symbol: symbol))

                        let expectedCompanyNamePartial = stockWithExpectedValues.expectedCompanyNamePartial
                        let expectedCompanySectorPartial = stockWithExpectedValues.expectedCompanySectorPartial
                        let expectedPrice = stockWithExpectedValues.expectedPrice
                        let expectedPriceMinimum = self.stockExpectedPriceRangeMinimum * expectedPrice
                        let expectedPriceMaximum = self.stockExpectedPriceRangeMaximum * expectedPrice
                        
                        expect(self.stockCurrentPrice).toEventually(beGreaterThan(expectedPriceMinimum))
                        expect(self.stockCurrentPrice).toEventually(beLessThan(expectedPriceMaximum))
                        expect(stockWithExpectedValues.expectedCompanyNamePartial.contains(<#T##element: Character##Character#>)
                        
                    }
                    

                        
                }
            }
        }
        
        
        
        
    
    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        print("... mostRecentAction = \(mostRecentAction)")
        switch mostRecentAction {
        case .stockQuoteServiceResponse(json: json)
            
            if let result = state.
            
            
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
