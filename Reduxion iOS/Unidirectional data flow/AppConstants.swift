//
//  AppConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond. All rights reserved.
//

import Foundation

struct ServiceHandlers {
    var mock: Service
    var real: Service
}

struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

protocol AppComponents {
    var allUseCaseComponents: [UseCaseComponents] { get }
}
