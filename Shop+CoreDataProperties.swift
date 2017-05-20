//
//  Shop+CoreDataProperties.swift
//  MADShops
//
//  Created by Daniel Ruiz on 20/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData


extension Shop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shop> {
        return NSFetchRequest<Shop>(entityName: "Shop")
    }

    @NSManaged public var address: String?
    @NSManaged public var description_en: String?
    @NSManaged public var description_es: String?
    @NSManaged public var name: String?
    @NSManaged public var opening_hours_en: String?
    @NSManaged public var opening_hours_es: String?
    @NSManaged public var logo: ShopLogo?
    @NSManaged public var locationImage: ShopLocationMap?

}
