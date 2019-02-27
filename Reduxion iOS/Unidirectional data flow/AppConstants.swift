//
//  AppConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond. All rights reserved.
//

import Foundation

struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}

protocol AppComponents {
    var allUseCaseComponents: [UseCaseComponents] { get }
}
