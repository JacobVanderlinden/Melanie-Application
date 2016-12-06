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
        self.changeBackgroundColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeBackgroundColor() {
        if Float(self.nevus.text!) > Float(self.dysplasticNevus.text!) {
            if Float(self.nevus.text!) > Float(self.melanoma.text!) {
                // N > DN > M
                // N Max
                changeBackgroundColorHelper("nevus")
            } else {
                // M > N > DN
                // M Max
                changeBackgroundColorHelper("melanoma")
            }
        } else {
            // DN > N
            if Float(self.dysplasticNevus.text!) > Float(self.melanoma.text!) {
                // DN > M > N
                changeBackgroundColorHelper("dysplasticNevus")
            } else {
                // M > DN > N
                changeBackgroundColorHelper("melanoma")
            }
        }
        
    }
    
    
    func changeBackgroundColorHelper(type: String) {
        switch type {
            case "nevus":
                self.backgroundColor = UIColor.greenColor()
                break
            case "dysplasticNevus":
                self.backgroundColor = UIColor.yellowColor()
                break
            case "melanoma":
                self.backgroundColor = UIColor.redColor()
                break
            default:
                self.backgroundColor = UIColor.whiteColor()
        }
    }

}
