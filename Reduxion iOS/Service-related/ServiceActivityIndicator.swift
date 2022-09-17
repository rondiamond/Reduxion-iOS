//
//  ServiceActivityIndicator.swift
//  Reduxion-iOS
//
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE file.
//

/**
 Single Responsibility (SRP):
 This file manages the network activity indicator.
 */

import Foundation
import UIKit

// MARK: - Network activity indicator

private var numberOfPendingShowActivityIndicatorRequests = 0

/**
 Shows the network activity spinner (and keeps track of the number of outstanding requests).
 */
func serviceRequestBegins() {
    numberOfPendingShowActivityIndicatorRequests += 1
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //SVProgressHUD.show()  // uncomment if using SVProgressHUD
}

/**
 Hides the network activity spinner (assuming this was the only pending request).
 */
func serviceRequestEnds() {
    numberOfPendingShowActivityIndicatorRequests -= 1
    if numberOfPendingShowActivityIndicatorRequests <= 0 {
        numberOfPendingShowActivityIndicatorRequests = 0
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //SVProgressHUD.dismiss()  // uncomment if using SVProgressHUD
    }
}

/**
 Hides the network activity spinner, regardless of any pending network requests.
 */
func forceserviceRequestEnds() {
    numberOfPendingShowActivityIndicatorRequests = 0
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //SVProgressHUD.dismiss()  // uncomment if using SVProgressHUD
}
