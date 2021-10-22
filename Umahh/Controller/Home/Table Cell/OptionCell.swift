//
//  OptionCell.swift
//  Umahh
//
//  Created by mac on 06/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {
    
    @IBOutlet weak var btnFeed : UIButton!
     @IBOutlet weak var btnQuran : UIButton!
     @IBOutlet weak var btnCommunity : UIButton!
     @IBOutlet weak var btnSettings : UIButton!
     @IBOutlet weak var btnQiblah : UIButton!
     @IBOutlet weak var btnQuiz : UIButton!
     @IBOutlet weak var btnPersonnage : UIButton!
    
    @IBOutlet weak var btnCalc : UIButton!
    @IBOutlet weak var btnHajiumrah : UIButton!
    @IBOutlet weak var btnSupplication : UIButton!
     @IBOutlet weak var btnBusiness : UIButton!
     @IBOutlet weak var btnOrganization : UIButton!
    
    
    @IBOutlet weak var lblFeed : UILabel!
        @IBOutlet weak var lblQuran : UILabel!
        @IBOutlet weak var lblCommunity : UILabel!
        @IBOutlet weak var lblSettings : UILabel!
        @IBOutlet weak var lblQiblah : UILabel!
        @IBOutlet weak var lblQuiz : UILabel!
        @IBOutlet weak var lblPersonnage : UILabel!
       
       @IBOutlet weak var lblCalc : UILabel!
       @IBOutlet weak var lblHajiumrah : UILabel!
       @IBOutlet weak var lblSupplication : UILabel!
        @IBOutlet weak var lblBusiness : UILabel!
        @IBOutlet weak var lblOrganization : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
