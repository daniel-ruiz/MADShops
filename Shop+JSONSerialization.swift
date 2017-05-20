//
//  Shop+JSONSerialization.swift
//  MADShops
//
//  Created by Daniel Ruiz on 14/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData

extension Shop {
    convenience init(json: JSONObject, context: NSManagedObjectContext) throws {
        self.init(context: context)
        
        guard let name = json["name"] as? String else {
            throw ShopSerializationError.missing("name")
        }
        
        self.name = name.capitalized
        description_en = json["description_en"] as? String
        description_es = json["description_es"] as? String
        opening_hours_en = json["opening_hours_en"] as? String
        opening_hours_es = json["opening_hours_es"] as? String
    }
}
