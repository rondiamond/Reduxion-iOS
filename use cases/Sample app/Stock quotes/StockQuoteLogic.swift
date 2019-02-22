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

struct StockQuoteLogic: Logic, HasService {
    var activeService: Service?
var mockService: Service = MockStockQuoteService(endpointBaseURL: SERVICE_URL_BASE)
var realService: Service = StockQuoteService(endpointBaseURL: SERVICE_URL_BASE)
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .stockQuoteServiceRequest(let symbol):
            if activeService != nil {
                if (symbol.count == 0) {
                    print("Error - can't do stock lookup without a stock symbol!")
                    return
                }
                // fetch data via service, and store it (could be real or mock service/data; we don't care)
                activeService?.fetchAndStoreData([:])
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
                state.stocksHistory.history.append(stockInfo)
                state.stocksHistory.currentIndex = state.stocksHistory.history.count - 1
            }
            break
    
        default:
            break
        }
    }
    
}








