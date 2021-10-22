//
//  PrayerTimeVC.swift
//  Umahh
//
//  Created by mac on 16/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PrayerTimeVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblPrayertime: UITableView!
     @IBOutlet weak var lblTime: UILabel!
     @IBOutlet weak var lblCity: UILabel!
     var arrayPrayerTime = NSArray();
    
     var arrayGlobalTime = NSMutableArray();
     @IBOutlet weak var lblmosquename: UILabel!
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        
        print(time)
        lblTime.text = time
        
        let mosquename:String = UserDefaults.standard.object(forKey: "mosque_name") as! String
        print(mosquename)
        lblmosquename.text = mosquename
        
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    @objc func timerAction() {
       
        let date = Date()
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "HH:mm"
               let time = dateFormatter.string(from: date)
               
               print(time)
               lblTime.text = time
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    
    
    func setViews()
    {
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "Prayer Schedule")
        
       tblPrayertime.register(UINib(nibName: "PrayerTimeCell", bundle: nil), forCellReuseIdentifier: "PrayerTimeCell")
        self.prayertimeApi()
        
      let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
                     
                     let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
            
              let geoCoder = CLGeocoder()
              let location = CLLocation(latitude: Double(latitude)!, longitude:  Double(longitude)!)

              geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in

                  placemarks?.forEach { (placemark) in

                      if let city = placemark.locality {
                          
                          print(city)
                          
                          print(city)
                          self.lblCity.text = city
                          
                          
                      } // Prints "New York"
                      
                  }
              })
        
       
    }
    
    func prayertimewithoutloginApi(){
        customLoader.show()
        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/prayer/getAll/5c88c59990361c17a8600e80"
        
        
      //  let urlPath =  "http://139.59.83.155:4002/api/mosque/prayer/getAll/\(mosqueid)"
        
        let urlPath =  "http://api.aladhan.com/v1/calendar?latitude=51.508515&longitude=-0.1254872&method=2&month=4&year=2017"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                let content = swiftyJsonVar["data"][0]
                print(content);
                
                let time  = content["timings"]
                print(time)
                
                let firstvalue = time["Dhuhr"]
                print(firstvalue)
                let secondvalue = time["Isha"]
                print(secondvalue)
                let thiredvalue = time["Midnight"]
                print(thiredvalue)
                let fourthvalue = time["Imsak"]
                print(fourthvalue)
                let fifthvalue = time["Asr"]
                print(fifthvalue)
                let sixvalue = time["Maghrib"]
                print(sixvalue)
                
                let sevenvalue = time["Fajr"]
                print(sevenvalue)
                let eightvalue = time["Sunset"]
                print(eightvalue)
                let ninevalue = time["Sunrise"]
                print(ninevalue)
                
                self.arrayGlobalTime.add(firstvalue)
                  self.arrayGlobalTime.add(secondvalue)
                  self.arrayGlobalTime.add(thiredvalue)
                  self.arrayGlobalTime.add(fourthvalue)
                  self.arrayGlobalTime.add(fifthvalue)
                  self.arrayGlobalTime.add(sixvalue)
                  self.arrayGlobalTime.add(sevenvalue)
                  self.arrayGlobalTime.add(eightvalue)
                  self.arrayGlobalTime.add(ninevalue)
                
                print(self.arrayGlobalTime)
                
               // self.tblPrayertime.reloadData()
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    
    
    func prayertimeApi(){
        customLoader.show()
        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
      

        
         let urlPath =  "http://167.172.131.53:4002/api/mosque/prayer/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.arrayPrayerTime = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayPrayerTime);
                self.tblPrayertime.reloadData()
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPrayerTime.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerTimeCell", for: indexPath) as! PrayerTimeCell
       let diccat = arrayPrayerTime.object(at: indexPath.row) as! JSON

        print(diccat)
        cell.lbltext.text = diccat["day"].stringValue
        cell.lblArabic.text = diccat["day_aerobic"].stringValue
        
        let startdateContent = diccat["time"].stringValue
        
        
        let startdateArr = startdateContent.components(separatedBy: " ")
        
        let startdate    = startdateArr[4]
        print(startdate)
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        
        let date1 = inputFormatter.date(from: startdate)

        let date2 = NSDate()

              var components1 = NSCalendar.current.dateComponents([.hour, .minute], from: date1!)

        let components2 = NSCalendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: date2 as Date)

              components1.year = components2.year;
              components1.month = components2.month;
              components1.day = components2.day;

              let date3 = NSCalendar.current.date(from: components1)

        let minutes = date3!.timeIntervalSince(date2 as Date)/60
              print(minutes)
        
         print(startdate)
            let time = Int(minutes)
            print(time)
        
        if time >= 10 && time <= 15 {
        
         
          //
            print("Yellow")
              cell.viewBg.backgroundColor = UIColor.yellow
           
             appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.yellow, width: 0.0, radious: 3.0)
          
            cell.lbltext.textColor = UIColor.black
              cell.lblArabic.textColor = UIColor.black
            cell.lblTime.textColor = UIColor.black
            cell.imgtime.tintColor = UIColor.black
        }
            
        else if time >= -10 && time <= -15    {
                               print("Green")
                                cell.viewBg.backgroundColor = UIColor.appThemeLightBlueColor()
                           appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.green, width: 0.0, radious: 3.0)
                              cell.lbltext.textColor = UIColor.white
                              cell.lblArabic.textColor = UIColor.white
                              cell.lblTime.textColor = UIColor.white
             cell.imgtime.tintColor = UIColor.white
                          }
        
       else if time >= 0 && time <= 10    {
                    print("Green")
                     cell.viewBg.backgroundColor = UIColor.appThemeLightBlueColor()
                appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.green, width: 0.0, radious: 3.0)
                   cell.lbltext.textColor = UIColor.white
                   cell.lblArabic.textColor = UIColor.white
                   cell.lblTime.textColor = UIColor.white
             cell.imgtime.tintColor = UIColor.white
               }
       
        
        
       
//        if time <= 10 && time >= -10   {
//             print("Green")
//              cell.viewBg.backgroundColor = UIColor.appThemeLightBlueColor()
//         appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.green, width: 0.0, radious: 3.0)
//            cell.lbltext.textColor = UIColor.white
//            cell.lblArabic.textColor = UIColor.white
//            cell.lblTime.textColor = UIColor.white
//        }
           
//       else if time >= -10   {
//                         print("Green")
//                          cell.viewBg.backgroundColor = UIColor.appThemeLightBlueColor()
//                        //appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.green, width: 0.0, radious: 3.0)
//                       cell.lbltext.textColor = UIColor.white
//                       cell.lblArabic.textColor = UIColor.white
//                       cell.lblTime.textColor = UIColor.white
//                   }
        
        else {
            
             appDelegate.setRoundRectAndBorderColor(view: cell.viewBg, color: UIColor.clear, width: 0.0, radious: 3.0)
            cell.lbltext.textColor = UIColor.green
            cell.lblArabic.textColor = UIColor.green
            cell.lblTime.textColor = UIColor.green
        }
        
       // cell.lbltext.text = hours
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
       
        

        
        cell.lblTime.text = startdate
        
        cell.selectionStyle = .none
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}
