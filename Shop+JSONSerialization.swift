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
    convenience init(json: JSONObject, context: NSManagedObjectContext) {
        self.init(context: context)
        
        name = json["name"] as? String
        address = json["address"] as? String
        description_en = json["description_en"] as? String
        description_es = json["description_es"] as? String
    }
}
