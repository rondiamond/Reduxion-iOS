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
        var currentEnvironment: ServiceEnvironment? = nil
        switch currentServicesType {
        case .mock:
            break
        case .real(let environment):
            currentEnvironment = environment
        }
        
        var logicUnits: [Logic] = []
        for componentsForUseCase in allUseCaseComponents {
            var logic = componentsForUseCase.logic
            var service: Service
            
            switch currentServicesType {
            case .mock:
                service = componentsForUseCase.services.mock
                break
            case .real(_):
                service = componentsForUseCase.services.real
                service.environment = currentEnvironment
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
