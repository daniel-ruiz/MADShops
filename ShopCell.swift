//
//  ShopCellTableViewCell.swift
//  MADShops
//
//  Created by Daniel Ruiz on 17/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
