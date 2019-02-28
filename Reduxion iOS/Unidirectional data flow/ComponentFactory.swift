//
//  ComponentFactory.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation


/**
 Protocol to return all use case components used in the application.
 This is an array of Logic units and Services (mock and real), organized by use case.
 */
protocol AllUseCaseComponents {
    var allUseCaseComponents: [UseCaseComponents] { get }
}


struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}

protocol AppComponents {
    var allUseCaseComponents: [UseCaseComponents] { get }
}


struct ComponentFactory: AppComponents, CurrentServicesType {
    static let shared = ComponentFactory()
    
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
