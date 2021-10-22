//
//  MosqueDetailCell.swift
//  Umahh
//
//  Created by mac on 06/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MosqueDetailCell: UITableViewCell {
     @IBOutlet weak var btnmosque : UIButton!
     @IBOutlet weak var btnmosqueDetail : UIButton!
    
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblmosqueaddress: UILabel!
     @IBOutlet weak var imgmosque: UIImageView!
    
    @IBOutlet weak var btnEducation : UIButton!
    @IBOutlet weak var btnActivity : UIButton!
    @IBOutlet weak var btnKhutba : UIButton!
    
    @IBOutlet weak var lblEducation : UILabel!
       @IBOutlet weak var lblActivity : UILabel!
       @IBOutlet weak var lblKhutba : UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        appDelegate.setRoundRectAndBorderColor(view: btnmosque, color: UIColor.clear, width: 0.0, radious: 5.0)
         appDelegate.setRoundRectAndBorderColor(view: imgmosque, color: UIColor.clear, width: 0.0, radious: imgmosque.frame.size.height/2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
