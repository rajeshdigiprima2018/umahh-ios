//
//  MyDonationCell.swift
//  Umahh
//
//  Created by mac on 28/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class MyDonationCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
     @IBOutlet weak var lblTransid: UILabel!
     @IBOutlet weak var lblPrice: UILabel!
     @IBOutlet weak var lblTime: UILabel!
       @IBOutlet weak var viewMain: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
