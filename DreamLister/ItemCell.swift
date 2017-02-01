//
//  ItemCell.swift
//  DreamLister
//
//  Created by New on 1/20/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!

    func configureCell(item: Item) {
        //Sets outlet equal to item title in the entity attributes
        title.text = item.title
        price.text = "$\(item.price)" //string interpolation. 
        details.text = item.details

        thumb.image = item.toImage?.image as? UIImage
    }


}
