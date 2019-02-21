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
    var service: Service?
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .stockQuoteServiceRequest(let symbol):
            if let stockQuoteService = service {
                if (symbol.count == 0) {
                    print("Error - can't do stock lookup without a stock symbol!")
                    return
                }
                // fetch data via service, and store it (could be real or mock service/data; we don't care)
                stockQuoteService.fetchAndStoreData([:])
            }
            break
        case .stockQuoteServiceResponse (let jsonPayload):
// TODO: parse response, and process data

            if (jsonPayload != JSON.null) {
                
                // parse response into a StockInfo object
                let symbol              = jsonPayload["symbol"].stringValue
                let companyName         = jsonPayload["companyName"].stringValue
                let sector              = jsonPayload["sector"].stringValue
                let primaryExchange     = jsonPayload["primaryExchange"].stringValue
                let latestPrice         = jsonPayload["latestPrice"].floatValue
                let latestUpdate        = jsonPayload["latestUpdate"].intValue
                let latestVolume        = jsonPayload["latestVolume"].intValue
                let previousClose       = jsonPayload["previousClose"].floatValue
                let change              = jsonPayload["change"].floatValue
                let changePercent       = jsonPayload["changePercent"].floatValue
                let week52High          = jsonPayload["week52High"].floatValue
                let week52Low           = jsonPayload["week52Low"].floatValue

                let stockData = stockInfo(
            }

                
                
                
            
            
            
            
            
            
            
            
var stockInfo = StockInfo(
            
            // append to StocksHistory
            
            // update index, current, etc.
    
    
    
    
    

                
                
    
            } else {
                print("Error - no response payload!")
            }
            

            
            break
    
    
            
            
            break

    
    
    
        default:
            break
        }
    }
    
}








