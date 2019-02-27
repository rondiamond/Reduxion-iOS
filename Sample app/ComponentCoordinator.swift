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
            case .real(_):
                service = useCaseComponents.services.real
                if (service is HasEnvironment) {

                    
                }
                break
            }
            logic.service = service
            logicUnits.append(logic)
        }

        initializeLogicCoordinator(logicUnits: logicUnits)
    }

    var allUseCaseComponents: [UseCaseComponents] {
        get {
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
