//
//  CommunityCell.swift
//  Umahh
//
//  Created by mac on 16/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var btnnoLike: UIButton!
    @IBOutlet weak var btnname: UIButton!
    @IBOutlet weak var btnLike: UIButton!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
