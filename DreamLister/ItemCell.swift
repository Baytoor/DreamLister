//
//  ItemCell.swift
//  DreamLister
//
//  Created by baytoor on 8/11/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(Int(item.price))"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
    }

}
