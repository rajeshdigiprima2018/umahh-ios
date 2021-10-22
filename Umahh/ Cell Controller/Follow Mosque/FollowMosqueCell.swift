//
//  FollowMosqueCell.swift
//  Umahh
//
//  Created by mac on 18/06/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FollowMosqueCell: UITableViewCell {
    
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblmosqueaddress: UILabel!
    @IBOutlet weak var imgMosque: UIImageView!
     @IBOutlet weak var btnunFollow: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: imgMosque, color: UIColor.clear, width: 0.0, radious: imgMosque.frame.size.height/2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
