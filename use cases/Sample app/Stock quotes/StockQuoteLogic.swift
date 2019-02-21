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

struct StockQuoteLogic: Logic, HasService {
    var service: Service?
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .stockQuoteServiceRequest:
            // fetch data via service, and store it (could be real or mock service/data; we don't care)
            if let stockQuoteService = service {
                stockQuoteService.fetchAndStoreData([:])
            }
            break
        case .stockQuoteServiceResponse (let json):
            // TODO: parse response, and process data
            _ = json
            
            
            // parse response into a StockInfo object
            let symbol =
            let companyName =
            let sector =
            let primaryExchange =
            let latestPrice =
            let latestUpdate =
            let latestVolume =
            let previousClose =
            let change =
            let changePercent =
            let week52High =
            let week52Low =
            
            
            
            
            
            
            
var stockInfo = StockInfo(
            
            // append to StocksHistory
            
            // update index, current, etc.
            
            
            
            break
        default:
            break
        }
    }
    
}



