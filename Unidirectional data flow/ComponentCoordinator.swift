//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

struct ComponentCoordinator: AppConstants {

    init() {
        
        // get current environment
        
        // initialize ServiceFactory, based on environment
        
        // initialize LogicCoordinator w/ logic units
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
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
