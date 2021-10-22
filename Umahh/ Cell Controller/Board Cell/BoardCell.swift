//
//  BoardCell.swift
//  Umahh
//
//  Created by mac on 15/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BoardCell: UITableViewCell {
    
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblmosqueposition: UILabel!
     @IBOutlet weak var lblmosquedescription: UILabel!
     @IBOutlet weak var imgBoard: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        appDelegate.setRoundRectAndBorderColor(view: imgBoard, color: UIColor.clear, width: 0.0, radious: imgBoard.frame.size.height/2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
