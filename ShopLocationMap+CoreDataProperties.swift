//
//  ShopLocationMap+CoreDataProperties.swift
//  MADShops
//
//  Created by Daniel Ruiz on 20/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData


extension ShopLocationMap {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopLocationMap> {
        return NSFetchRequest<ShopLocationMap>(entityName: "ShopLocationMap")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var shop: Shop?

}
