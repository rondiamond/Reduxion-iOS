//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/22/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import Foundation

struct UseCaseComponents {
    var logic: Logic
    var service: Service
    var mockService: Service    // ?
}

let useCaseComponents: [UseCaseComponents] = [
    UseCaseComponents(
        logic: StockQuoteLogic(),
        service: StockQuoteService(),
        mockService: MockStockQuoteService()
    )
]
