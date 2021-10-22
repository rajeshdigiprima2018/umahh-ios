//
//  BookmarkCell.swift
//  Umahh
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BookmarkCell: UITableViewCell {
    
    @IBOutlet var imgSupplication: UIImageView!
    @IBOutlet var lblTitle: UILabel!
     @IBOutlet var lblDestination: UILabel!
     @IBOutlet var lblDecription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
