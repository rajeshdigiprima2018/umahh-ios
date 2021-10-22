//
//  AssociateCell.swift
//  Umahh
//
//  Created by mac on 18/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AssociateCell: UITableViewCell {
    
    @IBOutlet weak var lbltext: UILabel!
     @IBOutlet weak var lblname: UILabel!
     @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgAssociate: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
//         appDelegate.setRoundRectAndBorderColor(view: imgAssociate, color: UIColor.clear, width: 0.0, radious: 40)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
