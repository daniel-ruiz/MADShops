//
//  AppDelegate.swift
//  MADShops
//
//  Created by Daniel Ruiz on 14/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit
import CoreData

typealias JSONObject = [String: Any]
typealias ShopsJSONResponse = [String: [JSONObject]]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CacheManager.shared.cacheShops()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
    }
}

