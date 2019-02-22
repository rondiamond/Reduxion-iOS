//
//  ServiceTypes.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This class contains constants controlling behavior of the Service layer.
 */

import Foundation

// MARK: - Services type

enum LogicCoordinatorServicesType {
    case mock
    case real(ServiceEnvironment)
}

enum ServiceEnvironment {
//    case none   // i.e., mock
    case development
    case staging
    case production
}

/**
 Selects the type of services injected into the logic coordinator -- i.e., for the running application vs. the unit tests.
 */
let currentLogicCoordinatorServicesType: LogicCoordinatorServicesType = .mock

/**
 Specifies the type of 'real' service environment, if any.
 */
let currentServiceEnvironment: ServiceEnvironment = .none
