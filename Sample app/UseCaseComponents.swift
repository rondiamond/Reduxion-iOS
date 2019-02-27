//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/22/19.
//  Copyright © 2019 Ron Diamond. All rights reserved.
//

import Foundation

struct ComponentsForUseCase {
    var logic: Logic
    var service: Service
    var mockService: Service    // ?
}

//var allUseCaseComponents: [ComponentsForUseCase] = [
//    ComponentsForUseCase(
//        logic: StockQuoteLogic(),
//        service: StockQuoteService(),
//        mockService: MockStockQuoteService()
//    )
//]

var allUseCaseComponents: [ComponentsForUseCase] = []

func initializeUseCaseComponents() {

    var logic = StockQuoteLogic()
    var service = StockQuoteService()
    
    switch <#value#> {
    case <#pattern#>:
        <#code#>
    default:
        <#code#>
    }
    logic.service =
    
    
    
    allUseCaseComponents = [ComponentsForUseCase(logic: StockQuoteLogic(),
                                                 service: StockQuoteService(),
                                                 mockService: MockStockQuoteService())]
    
    
    
    
    
}

