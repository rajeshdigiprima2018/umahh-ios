//
//  FeedCell.swift
//  Umahh
//
//  Created by mac on 16/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var lbltext: UILabel!
     @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var lblname: UILabel!
     @IBOutlet weak var lblmosquename: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
     @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var viewMain: UIView!
    
     @IBOutlet weak var heightconstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)
          appDelegate.setRoundRectAndBorderColor(view: imgProfile, color: UIColor.clear, width: 0.0, radious: imgProfile.frame.size.height/2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
