//
//  ShopLogo+CoreDataProperties.swift
//  MADShops
//
//  Created by Daniel Ruiz on 20/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData


extension ShopLogo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopLogo> {
        return NSFetchRequest<ShopLogo>(entityName: "ShopLogo")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var shop: Shop?

}
