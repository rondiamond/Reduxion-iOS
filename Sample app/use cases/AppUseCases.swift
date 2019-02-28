//
//  UseCase.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/27/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import Foundation

struct AppUseCases: UseCases {
    var useCases: [UseCase] {
        get {
            let _useCases: [UseCase] = [
                UseCase.init(name: "StockQuote",
                             logic: StockQuoteLogic(),
                             services: UseCaseServices.init(mock: MockStockQuoteService(),
                                                            real: StockQuoteService()
                    )
                )
            ]
            return _useCases
        }
    }
}
