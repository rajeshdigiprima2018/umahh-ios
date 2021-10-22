//
//  MarkerInfoView.swift
//  Drinker
//
//  Created by DevD on 29/01/19.
//  Copyright © 2019 DevD. All rights reserved.
//

import UIKit

protocol MapMarkerDDelegate: class {
    func didTapDInfoButton(data: NSDictionary)
}

class MarkerDInfoView: UIView {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var descriptionname: UILabel!
    //@IBOutlet weak var femaleRatio: UILabel!


    weak var delegate: MapMarkerDDelegate?
    var spotData: NSDictionary?

    @IBAction func didTapDInfoButton(_ sender: UIButton) {
        delegate?.didTapDInfoButton(data: spotData!)
    }

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MarkerDInfoView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
