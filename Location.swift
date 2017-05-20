//
//  Location.swift
//  MADShops
//
//  Created by Daniel Ruiz on 20/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData

extension Location {
    convenience init(json: JSONObject, context: NSManagedObjectContext) throws {
        self.init(context: context)
        
        guard let address = json["address"] as? String else {
            throw ShopSerializationError.missing("address")
        }
        
        guard let latitudeString = json["gps_lat"] as? String,
                let latitude = Double(latitudeString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) else {
            throw ShopSerializationError.missing("gps_lat")
        }
        
        guard let longitudeString = json["gps_lon"] as? String,
                let longitude = Double(longitudeString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) else {
            throw ShopSerializationError.missing("gps_lon")
        }
        
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
