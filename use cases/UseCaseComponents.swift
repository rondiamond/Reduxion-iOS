//
//  UseCaseComponents.swift
//  Reduxion-iOS
//
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation

protocol AllUseCaseComponents {
    var allUseCaseComponents: [UseCaseComponents] { get }
}

struct UseCaseComponents {
    var name: String
    var logic: Logic
    var services: ServiceHandlers
}

struct ServiceHandlers {
    var mock: Service
    var real: Service
}
