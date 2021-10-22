//
//  TimeCell.swift
//  Umahh
//
//  Created by mac on 06/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation

class TimeCell: UITableViewCell {
     @IBOutlet weak var btnPrayertime : UIButton!
     @IBOutlet weak var lblTime : UILabel!
      @IBOutlet weak var lblDay : UILabel!
      @IBOutlet weak var lblLocation : UILabel!
      @IBOutlet weak var lblDayArabic : UILabel!
    
    @IBOutlet weak var viewBg: UIView!
      @IBOutlet weak var lbltext: UILabel!
      @IBOutlet weak var lblPrayerTime: UILabel!
      @IBOutlet weak var imgtime: UIImageView!
      @IBOutlet weak var lblArabic: UILabel!
    
    var timer = Timer()

    override func awakeFromNib() {
        super.awakeFromNib()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)

         appDelegate.setRoundRectAndBorderColor(view: btnPrayertime, color: UIColor.white, width: 0.5, radious: 3.0)
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
               
               let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
      
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: Double(latitude)!, longitude:  Double(longitude)!)

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in

            placemarks?.forEach { (placemark) in

                if let city = placemark.locality {
                    
                    print(city)
                    
                    print(city)
                    self.lblLocation.text = city
                    
                    
                } // Prints "New York"
                
            }
        })
    }
    
    @objc func tick() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
       lblTime.text = time
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
