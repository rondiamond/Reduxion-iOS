//
//  StockQuoteLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE file.
//

import Foundation
import SwiftyJSON

/**
 Single Responsibility (SRP):
 This struct implements Logic for the "stock quotes" use case.
 */

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
//                let info = jsonPayload["chart"]["result"][0]["meta"]
                let info = jsonPayload["chart"]["result"][0]

                var stockInfo = DataModel.StockInfo()
                stockInfo.symbol            = info["meta"]["symbol"].stringValue
//                stockInfo.name              = info["shortName"].stringValue
                stockInfo.latestPrice       = info["meta"]["regularMarketPrice"].stringValue
                stockInfo.latestUpdateTime  = info["meta"]["regularMarketTime"].intValue
                stockInfo.latestVolume      = info["indicators"]["quote"][0]["volume"][0].intValue
                
                stockInfo.priceHigh         = info["indicators"]["quote"][0]["high"][0].floatValue
                stockInfo.priceLow          = info["indicators"]["quote"][0]["low"][0].floatValue
                
                stockInfo.exchangeName      = info["meta"]["exchangeName"].stringValue
                stockInfo.instrumentType    = info["meta"]["instrumentType"].stringValue
                stockInfo.firstTradeDate    = info["meta"]["firstTradeDate"].intValue
                
                if (state.dataModel.stocksHistory.history.count > 0),
                    (state.dataModel.stocksHistory.currentIndex != nil) {
                    // first, remove any history states 'forward' from here
                    let subrangeToDelete = state.dataModel.stocksHistory.currentIndex!+1 ..< state.dataModel.stocksHistory.history.count
                    state.dataModel.stocksHistory.history.removeSubrange(subrangeToDelete)
                }
                state.dataModel.stocksHistory.currentStock = stockInfo
                state.dataModel.stocksHistory.history.append(stockInfo)
                self.modifyCurrentIndex(deltaType: .increment, state: &state)
            }
            break
            
        case .historyGoBack:
            self.modifyCurrentIndex(deltaType: .decrement, state: &state)

        case .historyGoForward:
            self.modifyCurrentIndex(deltaType: .increment, state: &state)
            
        case .historyClear:
            state.dataModel.stocksHistory.history.removeAll()
            state.dataModel.stocksHistory.currentStock = nil
            state.dataModel.stocksHistory.currentIndex = nil
            state.dataModel.stocksHistory.canGoBack = false
            state.dataModel.stocksHistory.canGoForward = false
            state.dataModel.stocksHistory.enableHistoryClear = false
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
    
    func modifyCurrentIndex(deltaType: indexDelta, state: inout AppState) {
        let totalHistoryCount = state.dataModel.stocksHistory.history.count
        let maxIndex = totalHistoryCount - 1
        var index = state.dataModel.stocksHistory.currentIndex ?? 0

        index += deltaType.rawValue
        index = max(0, index)
        index = min(index, maxIndex)

        state.dataModel.stocksHistory.currentIndex = index
        state.dataModel.stocksHistory.currentStock = state.dataModel.stocksHistory.history[index]
        state.dataModel.stocksHistory.canGoBack = (index > 0)
        state.dataModel.stocksHistory.canGoForward = (index < totalHistoryCount-1)
        state.dataModel.stocksHistory.enableHistoryClear = (totalHistoryCount > 0)
    }
    
}
