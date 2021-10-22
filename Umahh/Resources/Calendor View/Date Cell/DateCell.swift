//
//  DateCell.swift
//  Umahh
//
//  Created by mac on 16/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventView.layer.cornerRadius = eventView.frame.height/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectionView.backgroundColor = UIColor.clear
    }

   
}
