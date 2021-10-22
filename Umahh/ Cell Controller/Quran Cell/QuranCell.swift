//
//  QuranCell.swift
//  Umahh
//
//  Created by mac on 16/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuranCell: UITableViewCell {
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
     @IBOutlet weak var lblarabicname: UILabel!
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
