//
//  ShopAnnotation.swift
//  MADShops
//
//  Created by Daniel Ruiz on 20/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import MapKit

class ShopAnnotation: NSObject, MKAnnotation {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return address
    }
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        
        super.init()
    }
    
    convenience init?(shop: Shop) {
        guard let name = shop.name,
            let shopLocation = shop.location,
            let address = shopLocation.address else {
                return nil
        }
        
        self.init(name: name, address: address, coordinate: CLLocationCoordinate2D(latitude: shopLocation.latitude, longitude: shopLocation.longitude))
        
    }
}
