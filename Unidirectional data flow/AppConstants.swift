//
//  SampleAppServiceConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond. All rights reserved.
//

import Foundation

/**
 Selects the type of services injected into the logic coordinator; and the service environment, if any.
 */
let currentServicesType: ServicesType = .real(.production)


protocol AppConstants {
    var currentServicesType: ServicesType { get }
    var allUseCaseComponents: [UseCaseComponents] { get }
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}

struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}





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


