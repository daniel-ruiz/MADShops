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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let context = CoreDataStack.sharedInstance.context
        let endpoint = "http://madrid-shops.com/json_new/getShops.php"
        let requestUrl = URL(string: endpoint)!
        let data_task = URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            if let error = error {
                print("Error while fetching shops: \(error.localizedDescription)")
            }
            
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: [JSONObject]] {
                
                for shopJson in json["result"]! {
                    // Initialize shops with context and shop JSON
                    let shop = Shop(json: shopJson, context: context)
                    print("Fetched: \(String(describing: shop.name))")
                }
                
                print("Done fetching shops!")
                
            } else {
                return print("No results 🙁...")
            }
            
        }
        
        data_task.resume()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
    }
}

