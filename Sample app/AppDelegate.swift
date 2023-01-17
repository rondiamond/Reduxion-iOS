//
//  AppDelegate.swift
//  Reduxion-iOS
//
//  Copyright © Ron Diamond.
//  Licensed per the LICENSE file.
//

/**
 Single Responsibility (SRP):
 This class handles application lifecycle events.
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        currentServicesType = .real(.production)
        //currentServicesType = .mock
        _ = UseCaseFactory.shared     // initialize
        LogicCoordinator.sharedInstance.recallAppState()

        LogicCoordinator.performAction(.applicationLaunched)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        LogicCoordinator.performAction(.applicationResigning)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        LogicCoordinator.sharedInstance.persistAppState()
        
        LogicCoordinator.performAction(.applicationBackgrounded)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        LogicCoordinator.performAction(.applicationForegrounding)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        LogicCoordinator.performAction(.applicationActivated)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        LogicCoordinator.sharedInstance.persistAppState()
        
        LogicCoordinator.performAction(.applicationTerminating)
    }

}
