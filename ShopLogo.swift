//
//  Image.swift
//  MADShops
//
//  Created by Daniel Ruiz on 17/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import CoreData

extension ShopLogo {
    convenience init(data: NSData, context: NSManagedObjectContext) {
        self.init(context: context)
        self.data = data
    }
}
