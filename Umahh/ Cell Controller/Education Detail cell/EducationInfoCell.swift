//
//  EducationInfoCell.swift
//  Umahh
//
//  Created by mac on 02/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class EducationInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblphone: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
