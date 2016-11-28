//
//  customViewCell.swift
//  Melanie
//
//  Created by Jacob on 11/21/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit

class customViewCell: UITableViewCell {

    @IBOutlet weak var nevus: UILabel!
    @IBOutlet weak var dysplasticNevus: UILabel!
    @IBOutlet weak var melanoma: UILabel!
    @IBOutlet weak var moleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
