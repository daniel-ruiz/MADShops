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
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "ShopCell"
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
        let cell: ShopCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShopCell
        
        if let shopName = shop.name, let logoData = shop.logo?.data {
            cell.nameLabel?.text = shopName
            cell.logoView.image = UIImage(data: logoData as Data)
        }
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ShopsController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShopDetail" {
            if let indexPath = self.tableView.indexPath(for: sender as! ShopCell) {
                let controller = segue.destination as! ShopDetailController
                controller.shop = cachedShops[indexPath.row]
            }
        }
    }
    
}
