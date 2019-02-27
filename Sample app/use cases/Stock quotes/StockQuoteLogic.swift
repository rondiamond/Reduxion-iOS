//
//  StockQuoteLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This class implements a sample Logic module for the Reduxion-iOS sample code.
 */

import Foundation
import SwiftyJSON

//struct StockQuoteLogic: Logic, HasService {
struct StockQuoteLogic: Logic {
    var service: Service?
//    var serviceTypes: ServiceTypes {
//        get {
//            return _serviceTypes
//        }
//    }
//
//private var _serviceTypes: ServiceTypes
    
//    func baseURL(for environment: ServiceEnvironment) -> String? {
//        var baseURL: String
//
//        switch environment {
//        case .none:
//            break
//        case .development, .staging, .production:
//            baseURL = STOCK_QUOTE_SERVICE_URL_BASE
//            break
//        }
//
//        return baseURL
//    }

    
    
    
    
//var mockService: Service = MockStockQuoteService()
//var realService: Service = StockQuoteService(endpointBaseURL: STOCK_QUOTE_SERVICE_URL_BASE)
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .stockQuoteServiceRequest(let symbol):
            if service != nil {
                if (symbol.count == 0) {
                    print("Error - can't do stock lookup without a stock symbol!")
                    return
                }
                // fetch data via service, and store it (could be real or mock service/data; we don't care)
                service?.fetchAndStoreData([StockQuoteServiceKey_Symbol : symbol])
            } else {
                
            }
            break

        case .stockQuoteServiceResponse (let jsonPayload, let error):
            if (error != nil) {
                print("stockQuoteServiceResponse - error = \(error!)")
            }
            
            if (jsonPayload != JSON.null) {
                var stockInfo = StockInfo()
                stockInfo.symbol            = jsonPayload["symbol"].stringValue
                stockInfo.name              = jsonPayload["companyName"].stringValue
                stockInfo.sector            = jsonPayload["sector"].stringValue
                stockInfo.primaryExchange   = jsonPayload["primaryExchange"].stringValue
                stockInfo.latestPrice       = jsonPayload["latestPrice"].floatValue
                stockInfo.latestUpdate      = jsonPayload["latestUpdate"].intValue
                stockInfo.latestVolume      = jsonPayload["latestVolume"].intValue
                stockInfo.previousClose     = jsonPayload["previousClose"].floatValue
                stockInfo.change            = jsonPayload["change"].floatValue
                stockInfo.changePercent     = jsonPayload["changePercent"].floatValue
                stockInfo.week52High        = jsonPayload["week52High"].floatValue
                stockInfo.week52Low         = jsonPayload["week52Low"].floatValue
            
                if (state.stocksHistory.history.count > 0),
                    (state.stocksHistory.currentIndex != nil) {
                    // remove any 'forward' history states
                    let subrangeToDelete = state.stocksHistory.currentIndex!..<state.stocksHistory.history.count
                    state.stocksHistory.history.removeSubrange(subrangeToDelete)
                }
                state.currentStockInfo = stockInfo
                state.stocksHistory.history.append(stockInfo)
                state.stocksHistory.currentIndex = state.stocksHistory.history.count - 1
            }
            break
    
        default:
            break
        }
    }
    
}








