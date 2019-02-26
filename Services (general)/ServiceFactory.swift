//
//  ServiceFactory.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This file contains protocols and classes related to the Service Factory.
 */

import Foundation

// MARK: - Services

/**
 Protocol adopted by object which implements a service.
 Includes entry point for requesting it to fetch data from its corresponding endpoint (and if applicable, store the results).
 */
protocol Service {
    /**
     Initializes the Service for a particular type of environment.
     */
    init(servicesType: ServicesType)
    
    /**
     Standard 'Service' entry method.  Initiates a fetch from a web service, using possible arguments.  Function returns nothing directly.  Results should be returned via a separate Action, once fetching/parsing is complete.
     */
    func fetchAndStoreData(_ optionalArguments: [String : String])
}

/**
 Protocol adopted by a service which has an external endpoint.
 */
protocol HasEnvironment {
    /// Environment is injected by the service factory.
    init(environment: ServiceEnvironment)
}


// MARK: - Service Factory

protocol ServiceFactoryProtocol {
    var stockQuoteService: StockQuoteServiceProtocol { get }
}

/**
 Holds references to all relevant services.  These are injected into the LogicController (so that mock services/data can be substituted when needed for testing.)
 */
class ServiceFactory: ServiceFactoryProtocol {
    var stockQuoteService: StockQuoteServiceProtocol
    // ... other services go here

    init() {
        switch currentServiceEnvironmentType {
        case .mock:
            assert(false, "Error - ServiceFactory needs an environment type!")
        case .real(let environment):
            if let baseURL = StockQuoteService.baseURL(for: environment) {
                self.stockQuoteService = StockQuoteService(endpointBaseURL: baseURL)
            } else {
                assert(false, "Error - ServiceFactory needs a base URL!")
            }
            // ... other services
            break
        }
    }
}

/**
 A mock ServiceFactory, which substitutes mock services/data for testing purposes.  Injected into the LogicController, which in turn injects those references into relevant Logic modules.
 */
class MockServiceFactory: ServiceFactory {
    init(environment: ServiceEnvironment) {
        super.init()
        self.stockQuoteService = MockStockQuoteService()
        // ... other mock services
    }
}
