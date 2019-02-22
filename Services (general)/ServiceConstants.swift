//
//  ServiceConstants.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 2/20/19.
//  Copyright © 2018-2019 Ron Diamond. All rights reserved.
//

/**
 Single Responsibility (SRP):
 This file contains constants related to the Service layer.
 */

import Foundation

// MARK: - HTTP response codes
/*
 https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml :
 1xx: Informational - Request received, continuing process
 2xx: Success - The action was successfully received, understood, and accepted
 3xx: Redirection - Further action must be taken in order to complete the request
 4xx: Client Error - The request contains bad syntax or cannot be fulfilled
 5xx: Server Error - The server failed to fulfill an apparently valid request
 */

// HTTP Status Codes - General Types
let HTTP_RESPONSE_STATUS_CODE_TYPE_1xx_INFORMATIONAL    = 100
let HTTP_RESPONSE_STATUS_CODE_TYPE_2xx_SUCCESS          = 200
let HTTP_RESPONSE_STATUS_CODE_TYPE_3xx_REDIRECTION      = 300
let HTTP_RESPONSE_STATUS_CODE_TYPE_4xx_CLIENT_ERROR     = 400
let HTTP_RESPONSE_STATUS_CODE_TYPE_5xx_SERVER_ERROR     = 500

// HTTP Status Codes - Specific Codes
let HTTP_RESPONSE_STATUS_CODE_200_OK                    = 200
let HTTP_RESPONSE_STATUS_CODE_400_BAD_REQUEST           = 400
let HTTP_RESPONSE_STATUS_CODE_401_UNAUTHORIZED          = 401
let HTTP_RESPONSE_STATUS_CODE_403_FORBIDDEN             = 403
let HTTP_RESPONSE_STATUS_CODE_404_NOT_FOUND             = 404
let HTTP_RESPONSE_STATUS_CODE_504_GATEWAY_TIMEOUT       = 504


// MARK: - Paths
let SERVICE_URL_BASE                = "https://api.iextrading.com/1.0/"
let SERVICE_URL_STOCK_QUOTE_FORMAT  = "stock/%@/quote"


// MARK: - Request headers
let SERVICE_REQUEST_HEADER_CONTENT_TYPE = "Content-Type"
let SERVICE_REQUEST_HEADER_CONTENT_TYPE_JSON = "application/json"
let SERVICE_REQUEST_HEADER_GET = "GET"
let SERVICE_REQUEST_HEADER_POST = "POST"


// MARK: - Latency
let networkTimeoutInSeconds: TimeInterval           = 10.0
let mockServiceSimulatedLatencyInSeconds: Double    = 0.5