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
 Protocol adopted by a service which has an external endpoint.
 */
protocol HasEnvironment {
    /// Environment is injected by the service factory.
    init(environment: ServiceEnvironment)
}


// MARK: - Service Factory

/**
 Holds references to all relevant services, whether real or mock.  These are injected into the LogicController, which in turn injects those references into relevant Logic modules.
 */
struct ServiceFactory {
    private var services: [Service]
    
    
//    var stockQuoteService: Service?
//    // ... other services go here

    init(environmentType: ServicesType) {
        switch currentServicesType {
        case .mock:
            self.stockQuoteService = MockStockQuoteService()
            break
        case .real(let environment):
            self.stockQuoteService = StockQuoteService(environment: environment)
            // ... other services
            break
        }
    }
}
