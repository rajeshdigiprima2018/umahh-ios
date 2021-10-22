//
//  HajiumrahCell.swift
//  Umahh
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class HajiumrahCell: UITableViewCell {
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var viewMain: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
         appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 3.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
