//
//  QuranDetailCell.swift
//  Umahh
//
//  Created by mac on 18/06/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuranDetailCell: UITableViewCell {
    
      @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblname: UILabel!
     @IBOutlet weak var lblnameAr: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 10.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
