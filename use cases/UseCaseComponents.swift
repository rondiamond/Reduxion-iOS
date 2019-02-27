//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

var allUseCaseComponents: [UseCaseComponents] {
    get {
        var _allUseCaseComponents: [UseCaseComponents]
        _allUseCaseComponents = {
            UseCaseComponents.init(name: "StockQuote",
                                   logic: StockQuoteLogic(),
                                   services: ServiceHandlers.init(mock: MockStockQuoteService(),
                                                                  real: StockQuoteService())    // FIX
            )
        }
        
        return _allUseCaseComponents
    }
}



struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}
