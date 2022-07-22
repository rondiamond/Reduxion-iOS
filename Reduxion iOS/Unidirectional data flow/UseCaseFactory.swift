//
//  UseCaseFactory.swift
//  Reduxion-iOS
//
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

/**
 Protocol to return all Use Cases used in the application.
 This is an array of Logic units and Services (mock and real), organized by individual use case.
 */
protocol UseCases {
    var useCases: [UseCase] { get }
}

/**
 A 'use case' consists of the components used to implement a particular logical purpose in the application.
 */
struct UseCase {
    var logic: Logic
    var services: UseCaseServices
}

struct UseCaseServices {
    var mock: Service
    var real: Service
}

struct UseCaseFactory {
    static let shared = UseCaseFactory()
    
    init() {
        var currentEnvironment: ServiceEnvironment? = nil
        guard (currentServicesType != nil) else {
            fatalError("Error: currentServicesType must be set!")
        }
        
        switch currentServicesType! {
        case .mock:
            break
        case .real(let environment):
            currentEnvironment = environment
        }
        
        var logicUnits: [Logic] = []
        for useCase in useCases {
            var logic = useCase.logic
            var service: Service
            
            switch currentServicesType! {
            case .mock:
                service = useCase.services.mock
                break
            case .real(_):
                service = useCase.services.real
                service.environment = currentEnvironment
                break
            }
            logic.service = service
            logicUnits.append(logic)
        }
        initializeLogicCoordinator(logicUnits: logicUnits)
    }
}
