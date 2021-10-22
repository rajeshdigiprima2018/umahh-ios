//
//  PersonnageCell.swift
//  Umahh
//
//  Created by mac on 16/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PersonnageCell: UITableViewCell {
    
     @IBOutlet weak var lbltitle: UILabel!
     @IBOutlet weak var viewMain: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
