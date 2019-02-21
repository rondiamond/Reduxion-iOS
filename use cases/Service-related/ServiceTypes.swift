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
    case real
}

/**
 Selects the type of services injected into the logic coordinator, for the running application (vs. the unit tests)
 */
let currentLogicCoordinatorServicesType: LogicCoordinatorServicesType = .real
