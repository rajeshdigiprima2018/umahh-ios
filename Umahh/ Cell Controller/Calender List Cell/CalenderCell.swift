//
//  CalenderCell.swift
//  Umahh
//
//  Created by mac on 15/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CalenderCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var viewBg: UIView!

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
