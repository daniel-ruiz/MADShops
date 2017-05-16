//
//  ShopDetailController.swift
//  MADShops
//
//  Created by Daniel Ruiz on 16/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class ShopDetailController: UIViewController {

    var shop: Shop?
    
    convenience init() {
        self.init(shop: nil)
    }
    
    init(shop: Shop?) {
        self.shop = shop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.title = shop?.name!
    }
}
