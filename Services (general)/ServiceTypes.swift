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

// MARK: - Service type & Environment

enum ServicesType {
    case mock
    case real(ServiceEnvironment)
}

enum ServiceEnvironment {
    case development
    case staging
    case production
    // more as needed ...
}
