//
//  QuizQuesAnsCell.swift
//  Umahh
//
//  Created by mac on 08/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuizQuesAnsCell: UITableViewCell {
    
      @IBOutlet var lblQuestion: UILabel!
    
      @IBOutlet var btnAns1: UIButton!
     @IBOutlet var btnAns2: UIButton!
     @IBOutlet var btnAns3: UIButton!
     @IBOutlet var btnAns4: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
