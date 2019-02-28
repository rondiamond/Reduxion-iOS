//
//  UseCase.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/27/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import Foundation

var AllUseCases: [UseCase] {
    get {
        let _AllUseCases: [UseCase] = [
            UseCase.init(name: "StockQuote",
                                   logic: StockQuoteLogic(),
                                   services: ServiceHandlers.init(mock: MockStockQuoteService(),
                                                                  real: StockQuoteService()
                )
            )
        ]
        return _AllUseCases
    }
}
