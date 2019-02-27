//
//  AppConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond. All rights reserved.
//

import Foundation

/*
/**
 Selects the type of services injected into the logic coordinator; and the service environment, if any.
 */
let currentServicesType: ServicesType = .real(.production)
 */

protocol AppComponents {
    var currentServicesType: ServicesType { get }
    var allUseCaseComponents: [UseCaseComponents] { get }
}

protocol CurrentServicesType {
    <#requirements#>
 let currentServicesType: ServicesType = .real(.production)
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}

struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

