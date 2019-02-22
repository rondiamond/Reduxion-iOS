//
//  StockQuoteService.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol StockQuoteServiceProtocol: Service {
    // protocol to ensure proper typing in LogicCoordinator and ServiceFactory
}

// MARK: - Dictionary keys

let StockQuoteServiceKey_Symbol = "StockQuoteServiceKey_Symbol"


// MARK: - Service paths

let STOCK_QUOTE_SERVICE_URL_BASE    = "https://api.iextrading.com/1.0/"
let STOCK_QUOTE_SERVICE_URL_FORMAT  = "stock/%@/quote"


// MARK: - StockQuoteService

struct StockQuoteService: StockQuoteServiceProtocol {
    var endpointBaseURL: String
    
    func fetchAndStoreData(_ optionalArguments: [String : String]) {
        assert(self.endpointBaseURL != EMPTY_STRING, "Invalid endpointBaseURL - could not process service request!")

        guard let stockSymbol = optionalArguments[StockQuoteServiceKey_Symbol] else {
            print("Error - can't do stock lookup without a stock symbol!")
            return
        }
        
        let subpath = String(format: STOCK_QUOTE_SERVICE_URL_FORMAT, stockSymbol)
        let urlString = self.endpointBaseURL + subpath
        
        serviceRequestBegan()
        
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
                    parseAndStoreData(json: json, error: nil)
                    break
                    
                case .failure(let error):
                    // TODO: handle error case
                    print("Request failed with error: \(error)")
                }
                
                serviceRequestEnded()
        }
    }
}

struct MockStockQuoteService: StockQuoteServiceProtocol {
    var endpointBaseURL: String
    
    func fetchAndStoreData(_ optionalArguments: [String : String]) {
        let dispatchDeadline: DispatchTime = .now() + mockServiceSimulatedLatencyInSeconds
        DispatchQueue.main.asyncAfter(deadline: dispatchDeadline) {
            let sampleStockQuoteData = self.sampleStockQuoteData()
            parseAndStoreData(json: sampleStockQuoteData, error: nil)
        }
    }
    
    fileprivate func sampleStockQuoteData() -> JSON {
        var sampleStockQuoteData = JSON.null  // default value
        if let path = Bundle.main.path(forResource: "StockQuoteMockData", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    try sampleStockQuoteData = JSON(data: data)
                } catch {
                    print("Error: Unable to parse JSON for sampleStockQuoteData!")
                }
            }
        }
        return sampleStockQuoteData
    }
}

internal func parseAndStoreData(json: JSON, error: String?) {
    LogicCoordinator.performAction(Action.stockQuoteServiceResponse(json: json, error: error))
    // hand off payload as-is - will be parsed by Logic unit
}
