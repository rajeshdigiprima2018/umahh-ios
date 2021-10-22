//
//  IntroCell.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class IntroCell: UICollectionViewCell {
      @IBOutlet var imgBg: UIImageView!
     @IBOutlet var lblTitle: UILabel!
     @IBOutlet var lblDescription: UILabel!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var btnLogin: UIButton!
     @IBOutlet var btnSkip: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
