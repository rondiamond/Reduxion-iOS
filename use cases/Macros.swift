//
//  Macros.swift
//  Reduxion-iOS
//
//  Copyright © 2016-2018 Ron Diamond. All rights reserved.
//

import Foundation

// MARK: - Network activity indicator

private var numberOfPendingShowActivityIndicatorRequests = 0

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

func hideNetworkActivityIndicator() {
    numberOfPendingShowActivityIndicatorRequests -= 1
    if numberOfPendingShowActivityIndicatorRequests <= 0 {
        numberOfPendingShowActivityIndicatorRequests = 0
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //SVProgressHUD.dismiss()  // uncomment if using SVProgressHUD
    }
}
