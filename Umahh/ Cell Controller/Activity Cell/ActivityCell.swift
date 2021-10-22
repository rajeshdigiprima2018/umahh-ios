//
//  ActivityCell.swift
//  Umahh
//
//  Created by mac on 15/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var imgActivity: UIImageView!
     @IBOutlet weak var btnMore: UIButton!
    
   

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: imgActivity, color: UIColor.clear, width: 0.0, radious: 10.0)
        appDelegate.setRoundRectAndBorderColor(view: btnMore, color: UIColor.clear, width: 1.0, radious: 2.0)
        // Initialization code
    }

}
