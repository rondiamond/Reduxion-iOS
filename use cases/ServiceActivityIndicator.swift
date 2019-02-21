//
//  ServiceActivityIndicator.swift
//  Reduxion-iOS
//
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import Foundation
import UIKit

// MARK: - Network activity indicator

private var numberOfPendingShowActivityIndicatorRequests = 0

/**
 Shows the network activity spinner (and keeps track of the number of outstanding requests).
 */
func showNetworkActivityIndicator() {
    numberOfPendingShowActivityIndicatorRequests += 1
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //SVProgressHUD.show()  // uncomment if using SVProgressHUD
}

/**
 Hides the spinner, regardless of any pending network requests.
 */
func forceHideNetworkActivityIndicator() {
    numberOfPendingShowActivityIndicatorRequests = 0
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //SVProgressHUD.dismiss()  // uncomment if using SVProgressHUD
}

/**
 Hides the network activity spinner (assuming this was the only pending request).
 */
func hideNetworkActivityIndicator() {
    numberOfPendingShowActivityIndicatorRequests -= 1
    if numberOfPendingShowActivityIndicatorRequests <= 0 {
        numberOfPendingShowActivityIndicatorRequests = 0
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //SVProgressHUD.dismiss()  // uncomment if using SVProgressHUD
    }
}
