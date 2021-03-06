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

struct StockQuoteLogic: Logic {
    
    var service: Service?
    
    func performLogic(state: inout AppState, action: Action) {
        switch action {
        case .stockQuoteRequest(let symbol):
            if service != nil {
                if (symbol.count == 0) {
                    print("Error - can't do stock lookup without a stock symbol!")
                    return
                }
                // fetch data via service, and store it (could be real or mock service/data; we don't care)
                service?.fetchAndStoreData([StockQuoteServiceKey_Symbol : symbol])
            } else {
                print("Warning - no service handler specified!")
            }
            break

        case .stockQuoteResponse (let jsonPayload, let error):
            if (error != nil) {
                print("stockQuoteResponse - error = \(error!)")
            }
            
            if (jsonPayload != JSON.null) {
                var stockInfo = DataModel.StockInfo()
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

                if (state.dataModel.stocksHistory.history.count > 0),
                    (state.dataModel.stocksHistory.currentIndex != nil) {
                    // first, remove any history states 'forward' from here
                    let subrangeToDelete = state.dataModel.stocksHistory.currentIndex!+1..<state.dataModel.stocksHistory.history.count
                    state.dataModel.stocksHistory.history.removeSubrange(subrangeToDelete)
                }
                state.dataModel.stocksHistory.currentStock = stockInfo
                state.dataModel.stocksHistory.history.append(stockInfo)
                self.modifyCurrentIndex(delta: .increment, state: &state)
            }
            break
            
        case .goBackInHistory:
            self.modifyCurrentIndex(delta: .decrement, state: &state)

        case .goForwardInHistory:
            self.modifyCurrentIndex(delta: .increment, state: &state)
            
        case .clearHistory:
            state.dataModel.stocksHistory.history.removeAll()
            state.dataModel.stocksHistory.currentStock = nil
            state.dataModel.stocksHistory.currentIndex = nil
            state.dataModel.stocksHistory.canGoBack = false
            state.dataModel.stocksHistory.canGoForward = false
            state.dataModel.stocksHistory.enableClearHistory = false
        default:
            break
        }
        
        state.dataModel.stocksHistory.historyCountDescription = self.historyCountString(with: state)
    }

    enum indexDelta: Int {
        case decrement = -1
        case noChange = 0
        case increment = 1
    }
    
    func historyCountString(with state: AppState) -> String {
        let description: String
        if state.dataModel.stocksHistory.currentIndex != nil {
            let currentNumberInStockHistory = state.dataModel.stocksHistory.currentIndex! + 1
            let totalNumberOfStockLookups = state.dataModel.stocksHistory.history.count
            description = "\(currentNumberInStockHistory) of \(totalNumberOfStockLookups)"
        } else {
            description = ""
        }
        return description
    }
    
    func modifyCurrentIndex(delta: indexDelta, state: inout AppState) {
        let totalHistoryCount = state.dataModel.stocksHistory.history.count
        var index = state.dataModel.stocksHistory.currentIndex ?? -1

        index += delta.rawValue
        index = max(0, index)
        index = min(index, totalHistoryCount)

        state.dataModel.stocksHistory.currentIndex = index
        state.dataModel.stocksHistory.currentStock = state.dataModel.stocksHistory.history[index]
        state.dataModel.stocksHistory.canGoBack = (index > 0)
        state.dataModel.stocksHistory.canGoForward = (index < totalHistoryCount-1)
        state.dataModel.stocksHistory.enableClearHistory = (totalHistoryCount > 0)
    }
    
}
