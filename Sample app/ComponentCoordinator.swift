//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

struct ComponentCoordinator: AppComponents, CurrentServicesType {
    
    let currentServicesType: ServicesType = .real(.production)

    init() {

        
        
        
        // get current environment
        
        ServiceFactory.init(environmentType: currentServicesType)

        
        // make list of Logic units
        
        var logicUnits: [Logic]
        for useCaseComponents in allUseCaseComponents {
            let logic = useCaseComponents.logic
            let service: Service
            switch currentServicesType {
            case .mock:
                service = useCaseComponents.services.mock
                break
            case .real(let environment):
                service = useCaseComponents.services.real
                
                break
            }
            
            
            let service = useCaseComponents.services.
            
            
            // get Service for that Logic
            // append to list of LogicUnits
            
            
        }
        
        
        // inject into Logic Coordinator
//        initializeLogicCoordinator(logicUnits: <#T##[Logic]#>

        LogicCoordinator.sharedInstance
        
        
        
        // initialize LogicCoordinator w/ logic units
        
        
        
        
        
        
        
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



