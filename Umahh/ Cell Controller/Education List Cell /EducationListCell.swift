//
//  EducationListCell.swift
//  Umahh
//
//  Created by mac on 15/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class EducationListCell: UITableViewCell {
    
    @IBOutlet weak var lbleduname: UILabel!
    @IBOutlet weak var lbledutime: UILabel!
    @IBOutlet weak var lbledudate: UILabel!
     @IBOutlet weak var btnmore: UIButton!
     @IBOutlet weak var viewmain: UIView!
     @IBOutlet weak var imagedate: UIImageView!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        
        appDelegate.setRoundRectAndBorderColor(view: btnmore, color: UIColor.clear, width: 1.0, radious: 2.0)
         appDelegate.setRoundRectAndBorderColor(view: viewmain, color: UIColor.clear, width: 1.0, radious: 2.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
