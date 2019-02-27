//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

struct ComponentCoordinator: AppComponents, CurrentServicesType {
    
    internal let currentServicesType: ServicesType = .real(.production)

    init() {
        
        var logicUnits: [Logic] = []
        for useCaseComponents in allUseCaseComponents {
            var logic = useCaseComponents.logic
            let service: Service
            switch currentServicesType {
            case .mock:
                service = useCaseComponents.services.mock
                break
            case .real(let environment):
                service = useCaseComponents.services.real
                break
            }
            logic.service = service
            logicUnits.append(logic)
        }

        initializeLogicCoordinator(logicUnits: logicUnits)
        

        
        // inject into Logic Coordinator
//        initializeLogicCoordinator(logicUnits: <#T##[Logic]#>

//        _ = LogicCoordinator.sharedInstance   // instantiate singleton
//        initializeLogicCoordinator(logicUnits: <#T##[Logic]#>)
//        LogicCoordinator.sharedInstance.serviceFactory = ServiceFactory(environmentType: currentServicesType)


//        ServiceFactory.init(environmentType: currentServicesType)
        
        

        
        
        // initialize LogicCoordinator w/ logic units
        
        
        
        
        
        
        
    }
    
    

    var allUseCaseComponents: [UseCaseComponents] {
        get {
//            var _allUseCaseComponents: [UseCaseComponents]
            let _allUseCaseComponents: [UseCaseComponents] = [
                UseCaseComponents.init(name: "StockQuote",
                                       logic: StockQuoteLogic(),
                                       services: ServiceHandlers.init(mock: MockStockQuoteService(),
                                                                      real: StockQuoteService() )
                )
                ]
                
                return _allUseCaseComponents
            }
        }
}



