//
//  CacheManager.swift
//  MADShops
//
//  Created by Daniel Ruiz on 15/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData

class CacheManager {
    
    private static let _sharedInstance = CacheManager()
    static var shared: CacheManager {
        get {
            return _sharedInstance
        }
    }
    
    private static func checkCacheState() -> Bool {
        do {
            let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let shops = try CoreDataStack.sharedInstance.context.fetch(fetchRequest)
            
            return shops.count > 0
        } catch {
            print("Error while fetching cache: \(error.localizedDescription)")
            return false
        }
    }
    
    private var _alreadyCached: Bool
    var alreadyCached: Bool {
        get {
            return _alreadyCached
        }
    }
    
    private init() {
        _alreadyCached = CacheManager.checkCacheState()
    }
    
    
    func cacheShops(completion: (() -> ())?) {
        // TODO: Check Internet connection!!
        guard alreadyCached == false else { return }
        
        DispatchQueue.global(qos: .background).async {
            self.performCacheShops(completion: completion)
        }
        
    }
    
    private func performCacheShops(completion: (() -> ())?) {
        MADShopsClient().fetchShops { (json) in
            let context = CoreDataStack.sharedInstance.context
            
            for shopJson in json["result"]! {
                do {
                    let shop = try Shop(json: shopJson, context: context)
                    
                    if let shopLogo = shopJson["logo_img"] as? String,
                        let logoUrl = URL(string: shopLogo) {
                        do {
                            let logoData = try Data(contentsOf: logoUrl)
                            shop.logo = Image(data: logoData as NSData, context: context)
                            print("Fetched logo of \(String(describing: shop.name))!")
                        } catch {
                            print("Could not fetch logo of \(String(describing: shop.name)): \(error.localizedDescription)")
                        }
                    }
                    
                    
                    print("Fetched: \(String(describing: shop.name))")
                } catch {
                    print("Couldn't fetch shop due to the following error: \(error.localizedDescription)")
                }
            }
            
            if context.insertedObjects.count > 0 {
                DispatchQueue.main.async {
                    CoreDataStack.sharedInstance.saveContext()
                }
                
                self._alreadyCached = true
            }
            
            guard let completion = completion else { return }
            completion()
            
        }
    }
    
}
