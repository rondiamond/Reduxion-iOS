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

    /// used to verify that actual stock price is in range, relative to expected price
    let stockExpectedPriceRangeMinimum = 0.5
    let stockExpectedPriceRangeMaximum = 2.0

    
    struct StockQuoteTestData {
        let stockSymbol: String
//        let stockCurrentPrice: Float
//        let stockExpectedPriceMinimum: Float
//        let stockExpectedPriceMaximum: Float
        let stockExpectedCompanyNamePartial: String     // case insensitive
        let stockCompanySector: String                  // case insensitive
    }

    
    
    var stocksToTest: [StockQuoteTestData] = [
        ("aapl", 170.00, "apple", "tech"),
        ("goog", 1100.00, "google", "tech"),
        ("nflx", 360.00, "netflix", "consumer"),
        ("sbux", 70.00, "starbucks", "consumer"),
        ("tgt", 70.00, "target", "consumer")
    ]

    
//    let stock1 = ("aapl", 100.00, 300.00, "apple", "tech")
    
//    let stock1: StockQuoteTestData = ("aapl", 100.00, 300.00, "apple", "tech")
//    let stock2: StockQuoteTestData = ("goog", 750.00, 3000.00, "google", "tech")
//    let stock3: StockQuoteTestData = ("nflx", 200.00, 500.00, "netflix", "consumer")
//    let stock4: StockQuoteTestData = ("sbux", 40.00, 150.00, "starbucks", "consumer")
//    let stock5 = StockQuoteTestData(stockSymbol: <#T##String#>, stockExpectedPriceMinimum: <#T##Float#>, stockExpectedPriceMaximum: <#T##Float#>, stockExpectedCompanyNamePartial: <#T##String#>, stockCompanySector: <#T##String#>)
//        "tgt", 30, 150, "target", "consumer")
//
//
//
//    var stocksToTest: [StockQuoteTestData] = [
//
//        ]
    

    
    
    
//    var stocksToTest: [StockQuoteTestData] =
//    {
//        StockQuoteTestData(stockSymbol: <#T##String#>, stockCurrentPrice: <#T##Float#>, stockExpectedPriceMinimum: <#T##Float#>, stockExpectedPriceMaximum: <#T##Float#>),
//        StockQuoteTestData(stockSymbol: <#T##String#>, stockCurrentPrice: <#T##Float#>, stockExpectedPriceMinimum: <#T##Float#>, stockExpectedPriceMaximum: <#T##Float#>),
//        StockQuoteTestData(stockSymbol: <#T##String#>, stockCurrentPrice: <#T##Float#>, stockExpectedPriceMinimum: <#T##Float#>, stockExpectedPriceMaximum: <#T##Float#>),
//
//
//
//
//    }
    
    
    
    
    
    override func spec() {
        
        beforeSuite {
            print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
            print("** beforeSuite **")
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
//                    self.operand1 = 23
//                    self.operand2 = 45
//                    self.calculationType = .addition
//                    self.expectedResult = self.operand1 + self.operand2
                    self.stockSymbol = "MB"
//                    expect(self.stockCurrentPrice).toEventually(
                    
//                    self.stockCurrentPrice
                    LogicCoordinator.performAction(.stockQuoteServiceRequest(symbol: self.stockSymbol))
//                        calculate(operand1: self.operand1, operand2: self.operand2, calculationType: self.calculationType))
//                    expect(self.actualResult).toEventually(equal(self.expectedResult))
                }
            }
    }
    
    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        print("... mostRecentAction = \(mostRecentAction)")
        switch mostRecentAction {
        case .stockQuoteServiceResponse(json: json)
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
