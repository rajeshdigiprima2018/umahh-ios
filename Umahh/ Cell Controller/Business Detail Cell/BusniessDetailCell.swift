//
//  BusniessDetailCell.swift
//  Umahh
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BusniessDetailCell: UITableViewCell {
    
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewMain: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)
         appDelegate.setRoundRectAndBorderColor(view: imgProfile, color: UIColor.clear, width: 0.0, radious: 5.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
