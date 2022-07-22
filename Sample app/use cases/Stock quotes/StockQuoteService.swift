//
//  StockQuoteService.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 8/26/18.
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Dictionary keys

let StockQuoteServiceKey_Symbol = "StockQuoteServiceKey_Symbol"


// MARK: - Service paths

let STOCK_QUOTE_SERVICE_URL_BASE    = "https://query2.finance.yahoo.com/v8/finance/chart/"
let STOCK_QUOTE_SERVICE_URL_FORMAT  = "%@?interval=1m&range=1m&includePrePost=False&events=div,splits"


// MARK: - StockQuoteService

class StockQuoteService: Service {
    private var baseURL: String?
    private var _environment: ServiceEnvironment?
    
    var environment: ServiceEnvironment? {
        set {
            if (newValue != nil) {
                switch newValue! {
                case .development, .staging, .production:
                    self.baseURL = STOCK_QUOTE_SERVICE_URL_BASE
                    break
                }
            }
        }
        get {
            return self._environment
        }
    }
    
    func fetchAndStoreData(_ optionalArguments: [String : String]) {
        assert((self.baseURL?.count)! > 0, "Invalid endpointBaseURL - could not process service request!")

        guard let stockSymbol = optionalArguments[StockQuoteServiceKey_Symbol] else {
            print("Error - can't do stock lookup without a stock symbol!")
            return
        }
        
        let subpath = String(format: STOCK_QUOTE_SERVICE_URL_FORMAT, stockSymbol)
        let urlString = self.baseURL! + subpath
        
        serviceRequestBegan()
        
        var headers: [String : String] = [:]
        headers[SERVICE_REQUEST_HEADER_CONTENT_TYPE] = SERVICE_REQUEST_HEADER_CONTENT_TYPE_JSON
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(contentType: [SERVICE_REQUEST_HEADER_CONTENT_TYPE_JSON])
            .responseString { response in
                // handle any non-JSON errors here (e.g., HTML)
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
        }
        
        serviceRequestEnded()
    }
}

class MockStockQuoteService: StockQuoteService {
    
    override func fetchAndStoreData(_ optionalArguments: [String : String]) {
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

fileprivate func parseAndStoreData(json: JSON, error: String?) {
    LogicCoordinator.performAction(Action.stockQuoteResponse(json: json, error: error))
    // hand off payload as-is - will be parsed by Logic unit
}
