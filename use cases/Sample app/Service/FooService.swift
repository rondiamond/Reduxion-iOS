//
//  FooService.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2016-2018 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol FooServiceProtocol: Service {
    // protocol to ensure proper typing in LogicCoordinator and ServiceFactory
}

struct FooService: FooServiceProtocol {
    var endpointBaseURL: String
    
    func fetchAndStoreData(_ optionalArguments: [String : String]) {
        assert(self.endpointBaseURL != EMPTY_STRING, "Invalid endpointBaseURL - could not process service request!")
        
        let urlString = self.endpointBaseURL + SERVICE_URL_FOO_DATA
        
        showNetworkActivityIndicator()
        
        var headers: [String : String] = [:]
        headers[SERVICE_REQUEST_HEADER_CONTENT_TYPE] = SERVICE_REQUEST_HEADER_CONTENT_TYPE_JSON
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(contentType: [SERVICE_REQUEST_HEADER_CONTENT_TYPE_JSON])
            .responseString { response in
                // TODO: handle error (probably in HTML)
            }
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = SwiftyJSON.JSON(value)
                    parseAndStoreData(json)
                    break
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
                
                hideNetworkActivityIndicator()
        }
    }
}

struct MockFooService: FooServiceProtocol {
    var endpointBaseURL: String
    
    func fetchAndStoreData(_ optionalArguments: [String : String]) {
        let dispatchDeadline: DispatchTime = .now() + mockServiceSimulatedLatencyInSeconds
        DispatchQueue.main.asyncAfter(deadline: dispatchDeadline) {
            let sampleFooData = self.sampleFooData()
            parseAndStoreData(sampleFooData)
        }
    }
    
    fileprivate func sampleFooData() -> JSON {
        var sampleFooData = JSON.null  // default value
        if let path = Bundle.main.path(forResource: "sampleFooData", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    try sampleFooData = JSON(data: data)
                } catch {
                    print("Error: Unable to parse JSON for sampleFooData!")
                }
            }
        }
        return sampleFooData
    }
}

internal func parseAndStoreData(_ json: JSON) {
    LogicCoordinator.performAction(Action.fooServiceResponse(json: json))
    // hand off payload as-is - will be parsed by Logic unit
}
