//
//  NewsCell.swift
//  Umahh
//
//  Created by mac on 15/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var lbltext: UILabel!
     @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var btnViewmore: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
          appDelegate.setRoundRectAndBorderColor(view: imgNews, color: UIColor.clear, width: 0.0, radious: 10.0)
         appDelegate.setRoundRectAndBorderColor(view: btnViewmore, color: UIColor.clear, width: 0.0, radious: 5.0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
