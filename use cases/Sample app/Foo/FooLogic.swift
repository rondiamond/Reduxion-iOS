//
//  FooLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This class implements a sample Logic module for the Reduxion-iOS sample code.
 */

import Foundation

struct FooLogic: Logic, HasService {
    var service: Service?
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .fooServiceRequest:
            // fetch data via service, and store it (could be real or mock service/data; we don't care)
            if let fooService = service {
                fooService.fetchAndStoreData([:])
            }
            break
        case .fooServiceResponse (let json):
            // TODO: parse response, and process data
            _ = json
            break
        default:
            break
        }
    }
    
}
