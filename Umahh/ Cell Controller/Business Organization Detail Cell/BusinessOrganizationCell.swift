//
//  BusinessOrganizationCell.swift
//  Umahh
//
//  Created by mac on 29/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BusinessOrganizationCell: UICollectionViewCell {
    
    @IBOutlet weak var imgActivity: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
          appDelegate.setRoundRectAndBorderColor(view: imgActivity, color: UIColor.clear, width: 0.0, radious: 10.0)
        // Initialization code
    }

}
