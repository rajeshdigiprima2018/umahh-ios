//
//  PrayerTimeCell.swift
//  Umahh
//
//  Created by mac on 16/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PrayerTimeCell: UITableViewCell {
    
     @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgtime: UIImageView!
    @IBOutlet weak var lblArabic: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        appDelegate.setRoundRectAndBorderColor(view: viewBg, color: UIColor.clear, width: 0.0, radious: 3.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
