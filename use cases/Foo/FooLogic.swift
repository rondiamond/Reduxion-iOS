//
//  FooLogic.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//

/**
 Single Responsibility (SRP):
 This class implements a sample Logic module for the Reduxion-iOS sample code.
 */

import Foundation
import UIKit

class FooLogic: Logic, HasService {
    
    var service: Service?
    
    func performLogic(_ state: AppState, action: Action) {
        switch action {
        case .userRegistriesServiceRequest:
            // fetch data via service, and store it (could be real or mock service/data; we don't care)
            if let registryService = service {
                registryService.fetchAndStoreData([:])
            }
            break
            
        default:
            break
        }
    }
    
}
