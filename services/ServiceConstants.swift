//
//  ServiceConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016 Ron Diamond. All rights reserved.
//  Licensed per the LICENSE.txt file.
//

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
