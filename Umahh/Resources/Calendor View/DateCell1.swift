//
//  DateCell.swift
//  calendar
//
//  Created by Divya Nayak on 13/06/16.
//  Copyright © 2016 Aspire. All rights reserved.
//

import Foundation
import UIKit

class DateCell1 : UICollectionViewCell {
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.layer.cornerRadius = selectionView.frame.height/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectionView.backgroundColor = UIColor.clear
    }
    
}
