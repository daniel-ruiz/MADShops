//
//  ShopDetailController.swift
//  MADShops
//
//  Created by Daniel Ruiz on 16/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class ShopDetailController: UIViewController {

    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithShop()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    
    private func syncViewWithShop() {
        title = shop?.name
        
        if let locationImageData = shop?.locationImage?.data {
            locationImage.image = UIImage(data: locationImageData as Data)
        }
        addressLabel.text = shop?.location?.address
        openingHoursLabel.text = shop?.opening_hours_en
        descriptionLabel.text = shop?.description_en
    }
}
