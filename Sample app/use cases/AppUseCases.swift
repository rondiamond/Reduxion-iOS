//
//  UseCase.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/27/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import Foundation


/**
 The pre-defined use cases for the application.
 Each consists of a Logic unit, and two Service handlers (real and mock).
 */
var useCases: [UseCase] {
    get {
        let _useCases: [UseCase] = [
            UseCase.init(logic: StockQuoteLogic(),
                         services: UseCaseServices.init(mock: MockStockQuoteService(),
                                                        real: StockQuoteService()
                )
            )
            // more as needed ...
        ]
        return _useCases
    }
}
