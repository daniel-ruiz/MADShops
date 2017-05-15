//
//  ShopsController.swift
//  MADShops
//
//  Created by Daniel Ruiz on 15/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit
import CoreData

class ShopsController: UIViewController {
    
    var context = CoreDataStack.sharedInstance.context
    var cachedShops: [Shop] {
        get {
            let request: NSFetchRequest<Shop> = Shop.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.fetchBatchSize = 20
            request.sortDescriptors = [sortDescriptor]
            do {
                return try context.fetch(request)
            } catch {
                return []
            }
        }
    }

}


extension ShopsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cachedShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shop = cachedShops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        
        cell.textLabel?.text = shop.name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ShopsController: UITableViewDelegate {
    
}
