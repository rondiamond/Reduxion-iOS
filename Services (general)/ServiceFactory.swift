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
     Standard 'Service' entry method.  Initiates a fetch from a web service, using possible arguments.  Function returns nothing directly.  Results should be returned via a separate Action, once fetching/parsing is complete.
     */
    func fetchAndStoreData(_ optionalArguments: [String : String])
}

/**
 Protocol adopted by a service which has an external endpoint (e.g., a 'real' service, vs. a mock service).
 Real services must have a base URL, which potentially varies based on the type of environment.
 */
protocol HasEndpoint {
    /// This service's base URL for the different types of environments.
    static func baseURL(for environment: ServiceEnvironment) -> String?
    
    /// Service base URL currently in use for the current type of environment, injected by the service factory.
    init(endpointBaseURL: String)
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
        self.stockQuoteService = StockQuoteService(endpointBaseURL: STOCK_QUOTE_SERVICE_URL_BASE)
        // ... other services
    }
}

/**
 A mock ServiceFactory, which substitutes mock services/data for testing purposes.  Injected into the LogicController, which in turn injects those references into relevant Logic modules.
 */
class MockServiceFactory: ServiceFactory {
    override init() {
//        super.init()

        self.stockQuoteService = MockStockQuoteService(endpointBaseURL: STOCK_QUOTE_SERVICE_URL_BASE)
        // ... other mock services
    }
}
