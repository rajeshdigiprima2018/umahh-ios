//
//  MosqueContentCell.swift
//  Umahh
//
//  Created by mac on 07/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MosqueContentCell: UITableViewCell {
    
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblmosqueaddress: UILabel!
    @IBOutlet weak var lblmosquephone: UILabel!
    @IBOutlet weak var lblmosquewebsite: UILabel!
    @IBOutlet weak var lblmosqueemail: UILabel!
     @IBOutlet weak var lblmosquedescription: UILabel!
    
    @IBOutlet weak var btnPrayer: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnHomeMosque: UIButton!
    
    @IBOutlet weak var imgmosque: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
