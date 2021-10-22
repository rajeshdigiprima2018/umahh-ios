//
//  MosqueOptionCell.swift
//  Umahh
//
//  Created by mac on 07/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MosqueOptionCell: UITableViewCell {
    
     @IBOutlet weak var btnBoard: UIButton!
     @IBOutlet weak var btnKhutba: UIButton!
     @IBOutlet weak var btnCalendor: UIButton!
     @IBOutlet weak var btnEducation: UIButton!
     @IBOutlet weak var btnSuggestion: UIButton!
     @IBOutlet weak var btnActivities: UIButton!
     @IBOutlet weak var btnNews: UIButton!
     @IBOutlet weak var btnAssociates: UIButton!
     @IBOutlet weak var btnDonation: UIButton!
    
     @IBOutlet weak var lblBoard: UILabel!
     @IBOutlet weak var lblKhutba: UILabel!
     @IBOutlet weak var lblCalendor: UILabel!
     @IBOutlet weak var lblEducation: UILabel!
     @IBOutlet weak var lblSuggestion: UILabel!
     @IBOutlet weak var lblActivities: UILabel!
     @IBOutlet weak var lblNews: UILabel!
     @IBOutlet weak var lblAssociates: UILabel!
     @IBOutlet weak var lblDonation: UILabel!
     
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
