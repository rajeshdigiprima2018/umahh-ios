//
//  HomeVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRNotifications

class HomeVC: UIViewController,DrawerTransitionDelegate,SideMenuDelegae,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblHome: UITableView!
    
     @IBOutlet weak var lblHome: UILabel!
     @IBOutlet weak var lblBookmark: UILabel!
     @IBOutlet weak var lblSearch: UILabel!
     @IBOutlet weak var lblDonation: UILabel!
     @IBOutlet weak var lblSettings: UILabel!
    
    @IBOutlet weak var imgbg: UIImageView!
    
    private var leftMenu  = SideMenuViewController()
    private var leftDrawerTransition:DrawerTransition!
      var arrayPrayerTime = NSArray();
    
      var strimgurl = NSString();
    
     var dict = NSDictionary()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    // UserDefaults.standard.set("22.6941829330965", forKey: "current_latitude")
    // UserDefaults.standard.set("75.9295288670566", forKey: "current_longitude")
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
                                    print(dict)
        
        lblHome.text = (dict["Home"]! as! String)
        lblBookmark.text = (dict["Bookmark"]! as! String)
        lblSearch.text = (dict["Search"]! as! String)
        lblDonation.text = (dict["Donation"]! as! String)
        lblSettings.text = (dict["Settings"]! as! String)
        
        let hour = Calendar.current.component(.hour, from: Date())
        print(hour)
        switch hour {
        case 6..<12 :
            print(NSLocalizedString("Morning", comment: "Morning"))
            imgbg.image = UIImage(named: "Morning")
        case 12 :
            print(NSLocalizedString("Noon", comment: "Noon"))
             imgbg.image = UIImage(named: "Afternoon")
        case 13..<17 :
            print(NSLocalizedString("Afternoon", comment: "Afternoon"))
             imgbg.image = UIImage(named: "Afternoon")
        case 17..<22 :
            print(NSLocalizedString("Evening", comment: "Evening"))
             imgbg.image = UIImage(named: "evening")
        default:
            print(NSLocalizedString("Night", comment: "Night"))
             imgbg.image = UIImage(named: "night")
        }
      
        
      
        
        
        
       
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        leftMenu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        
        //leftMenu = self.storyboard?.instantiateViewController(withIdentifier:"SideMenuViewController") as! SideMenuViewController
        leftMenu.delegate = self
        self.leftDrawerTransition = DrawerTransition(target: self, drawer: leftMenu)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.navigationBar.isHidden = true
        setViews()
    }
    
    func setViews()
    {
        
         tblHome.register(UINib(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
         tblHome.register(UINib(nibName: "MosqueDetailCell", bundle: nil), forCellReuseIdentifier: "MosqueDetailCell")
         tblHome.register(UINib(nibName: "TimeCell", bundle: nil), forCellReuseIdentifier: "TimeCell")
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        self.mosqueDetailApi()
            self.prayertimeApi()
        }
        else {
              self.tblHome.isHidden = false
        }
        
       
    }
    
    func prayertimeApi(){
           customLoader.show()
           let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
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
                   print(self.arrayPrayerTime.count);
                   
                    self.tblHome.reloadData()
                   
                 
                   
                   customLoader.hide()
                   
                   break
               case .failure:
                   customLoader.hide()
                   print(Error.self)
               }
           }
       }
    
    func mosqueDetailApi(){
        customLoader.show()
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/user/getUserDetail/5cac4eab31c11e680e45f979"
        
        let urlPath =  "http://167.172.131.53:4002/api/user/getUserDetail/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                let data = swiftyJsonVar["data"]
                
                print(data as AnyObject)
                
                let imgurl = data["avtar"].stringValue
                print(imgurl)
                
                self.strimgurl  =  "http://167.172.131.53:4002\(imgurl)" as NSString
                print(self.strimgurl)
               self.tblHome.isHidden = false
                self.tblHome.reloadData()
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
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
             return 3
        }
        else {
        return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        
         if indexPath.row == 0 {
             return 320
        }
         else if indexPath.row == 1 {
             return 325
        }
         else {
        return 280
        }
        }
        else {
            if indexPath.row == 0 {
                return 320
            }
           
            else {
                return 280
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
            
             cell.btnPrayertime.addTarget(self, action: #selector(self.prayertime(_:)), for: .touchUpInside)
            
            cell.btnPrayertime.setTitle((dict["Prayer_Time"]! as! String), for: .normal)
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.string(from: date)
            
            print(time)
            cell.lblTime.text = time
            
            let dateFormattermonth = DateFormatter()
            dateFormattermonth.dateFormat = "EEEE | MMMM dd"
            let daymonth =  dateFormattermonth.string(from: date)
            cell.lblDay.text = daymonth
            
            
            let dateFor = DateFormatter()
            
            let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
            dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
            
            dateFor.calendar = hijriCalendar
            
            dateFor.dateFormat = "dd MMM yyyy"
            let daymonthar = dateFor.string(from: Date())
            
            cell.lblDayArabic.text = daymonthar
            
            if arrayPrayerTime.count > 0 {
                
                var times : [String] = []
                
                for dd in arrayPrayerTime {
                    let diccat = dd as! JSON
                    let startdateContent = diccat["time"].stringValue
                    
                    
                    let startdateArr = startdateContent.components(separatedBy: " ")
                    
                    let startdate    = startdateArr[4]
                    times.append(startdate)
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                let dateArray = times.map{ Calendar.current.dateComponents([.hour, .minute], from:formatter.date(from:$0)!) }
                let upcomingDates = dateArray.map { Calendar.current.nextDate(after: Date(), matching: $0, matchingPolicy: .nextTime)!  }
                let nextDate = upcomingDates.sorted().first!
                print(formatter.string(from:nextDate))
                
                for dd in arrayPrayerTime {
                    let diccat = dd as! JSON
                    let startdateContent = diccat["time"].stringValue
                    
                    
                    let startdateArr = startdateContent.components(separatedBy: " ")
                    
                    let startdate    = startdateArr[4]
                    if formatter.string(from:nextDate) == startdate {
                        print(diccat)
                        cell.lbltext.text = diccat["day"].stringValue
                        cell.lblArabic.text = diccat["day_aerobic"].stringValue
                        
                        let startdateContent = diccat["time"].stringValue
                        
                        
                        let startdateArr = startdateContent.components(separatedBy: " ")
                        
                        let startdate    = startdateArr[4]
                        print(startdate)
                        cell.lblPrayerTime.text = startdate
                        break
                    }
                }
                
    
            
            }
            
            
           
            
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MosqueDetailCell", for: indexPath) as! MosqueDetailCell
            cell.btnmosque.addTarget(self, action: #selector(self.mosquesearch(_:)), for: .touchUpInside)
             cell.btnmosqueDetail.addTarget(self, action: #selector(self.mosqueDetail(_:)), for: .touchUpInside)
            if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
            {
                
                let mosquename:String = UserDefaults.standard.object(forKey: "mosque_name") as! String
                print(mosquename)
               
                let mosqueaddress:String = UserDefaults.standard.object(forKey: "mosque_address") as! String
                print(mosqueaddress)
                
                cell.lblMosquename.text = mosquename
                cell.lblmosqueaddress.text = mosqueaddress
                
                cell.imgmosque.sd_setImage(with: URL(string: strimgurl as String), placeholderImage: UIImage(named: "mosque_default"))
            }
             cell.btnEducation.addTarget(self, action: #selector(self.educationDetail(_:)), for: .touchUpInside)
            
              cell.btnActivity.addTarget(self, action: #selector(self.activityDetail(_:)), for: .touchUpInside)
            
             cell.btnKhutba.addTarget(self, action: #selector(self.khutbaDetail(_:)), for: .touchUpInside)
            

            
             cell.btnmosque.setTitle((dict["Find_a_mosque"]! as! String), for: .normal)
            
             cell.lblKhutba.text = (dict["Khutba"]! as! String)
             cell.lblActivity.text = (dict["Activities"]! as! String)
             cell.lblEducation.text = (dict["Education"]! as! String)
            
            cell.selectionStyle = .none
            return cell
            
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
            
            //cell.btnFeed.tag = indexPath.row
            cell.btnFeed.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnQuran.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnCommunity.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnSettings.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnQiblah.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnQuiz.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnPersonnage.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnCalc.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnHajiumrah.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnSupplication.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnBusiness.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
             cell.btnOrganization.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            
            cell.lblFeed.text = (dict["Today_Feed"]! as! String)
            cell.lblQuran.text = (dict["Quran"]! as! String)
            cell.lblCommunity.text = (dict["Community"]! as! String)
            cell.lblSettings.text = (dict["Settings"]! as! String)
            cell.lblQiblah.text = (dict["Qiblah"]! as! String)
            cell.lblQuiz.text = (dict["Quiz"]! as! String)
            cell.lblPersonnage.text = (dict["Personage"]! as! String)
            cell.lblCalc.text = (dict["zakat_calc"]! as! String)
            cell.lblHajiumrah.text = (dict["haji_umrah"]! as! String)
            cell.lblSupplication.text = (dict["Supplication"]! as! String)
            cell.lblBusiness.text = (dict["Business"]! as! String)
            cell.lblOrganization.text = (dict["Organization"]! as! String)
            
       
       
        cell.selectionStyle = .none
             return cell
            }
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
                
                cell.btnPrayertime.addTarget(self, action: #selector(self.prayertime(_:)), for: .touchUpInside)
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let time = dateFormatter.string(from: date)
                
                print(time)
                cell.lblTime.text = time
                
                let dateFormattermonth = DateFormatter()
                dateFormattermonth.dateFormat = "EEEE | MMMM dd"
                let daymonth =  dateFormattermonth.string(from: date)
                cell.lblDay.text = daymonth
                
                
                let dateFor = DateFormatter()
                
                let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
                dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
                
                dateFor.calendar = hijriCalendar
                
                dateFor.dateFormat = "dd MMM yyyy"
                let daymonthar = dateFor.string(from: Date())
                
                 cell.lblDayArabic.text = daymonthar
                
                cell.selectionStyle = .none
                return cell
            }
           
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
                
                //cell.btnFeed.tag = indexPath.row
                cell.btnFeed.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnQuran.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnCommunity.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnSettings.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnQiblah.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnQuiz.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnPersonnage.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnCalc.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnHajiumrah.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnSupplication.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnBusiness.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                cell.btnOrganization.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
                
                cell.selectionStyle = .none
                return cell
            }
        }
       
    }
    
    
    @objc func khutbaDetail(_ sender: UIButton) {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        UserDefaults.standard.set(mosqueid, forKey: "sel_mosque_id")
        let callVC:KhutbaVC = ViewControllerHelper.getViewController(ofType: .khutba) as! KhutbaVC
        callVC.mosqueid = mosqueid
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationController?.pushViewController(callVC, animated: true)
    }

    @objc func educationDetail(_ sender: UIButton) {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        UserDefaults.standard.set(mosqueid, forKey: "sel_mosque_id")
        let callVC:EducationListVC = ViewControllerHelper.getViewController(ofType: .Edulist) as! EducationListVC
        callVC.mosqueid = mosqueid
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @objc func activityDetail(_ sender: UIButton) {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        UserDefaults.standard.set(mosqueid, forKey: "sel_mosque_id")
        let callVC:ActivityList = ViewControllerHelper.getViewController(ofType: .activitiesList) as! ActivityList
        callVC.mosqueid = mosqueid
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @IBAction func menuBtnClicked(sender: UIButton)
    {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    @IBAction func notificationClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
               {
        let myViewController = NotificationVC(nibName: "NotificationVC", bundle: nil)
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         self.navigationController?.pushViewController(myViewController, animated: true)
        }
        else {
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
        
        
    }
    
    @IBAction func detailClicked(_ sender: Any) {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = mosqueid
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
    }
    @IBAction func homeClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .home)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func bookmarkClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        let callVC = ViewControllerHelper.getViewController(ofType: .Bookmark)
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: false)
        }
        else {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
        
        
    }
    @IBAction func searchClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .Search)
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func donationClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        
        let myViewController = NewMosqueList(nibName: "NewMosqueList", bundle: nil)
       self.navigationController?.pushViewController(myViewController, animated: true)
        }
        else {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
        
        
    }
     @IBAction func settingsClicked(_ sender: Any) {
    let callVC = ViewControllerHelper.getViewController(ofType: .settings)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    
    @objc func mosquesearch(_ sender: UIButton) {
        let callVC = ViewControllerHelper.getViewController(ofType: .Search)
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @objc func mosqueDetail(_ sender: UIButton) {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
         UserDefaults.standard.set(mosqueid, forKey: "sel_mosque_id")
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = mosqueid
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.pushViewController(callVC, animated: true)
    }
     @objc func prayertime(_ sender: UIButton) {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
               {
        
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
               print(mosqueid)
               UserDefaults.standard.set(mosqueid, forKey: "sel_mosque_id")
        let myViewController = PrayerTimeVC(nibName: "PrayerTimeVC", bundle: nil)
                   self.navigationController?.pushViewController(myViewController, animated: true)
        }
        else {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
    }
    
    @objc func mosquemenuClicked(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag == 0 {
            let callVC = ViewControllerHelper.getViewController(ofType: .feed)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 1 {
            let callVC = ViewControllerHelper.getViewController(ofType: .Quranlist)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 2 {
            let callVC = ViewControllerHelper.getViewController(ofType: .CommunityList)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 3 {
            let callVC = ViewControllerHelper.getViewController(ofType: .settings)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 4 {
            let callVC = ViewControllerHelper.getViewController(ofType: .Qiblah)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 5 {
            let callVC = ViewControllerHelper.getViewController(ofType: .Quiz)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 6 {
            let callVC = ViewControllerHelper.getViewController(ofType: .personage)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 7 {
//            let callVC = ViewControllerHelper.getViewController(ofType: .Zakat_calc)
//             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 8 {
            let callVC = ViewControllerHelper.getViewController(ofType: .Hajiumrah)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 9 {
            let callVC = ViewControllerHelper.getViewController(ofType: .Supplication)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        else if sender.tag == 10{
            let callVC = ViewControllerHelper.getViewController(ofType: .business)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        
        else {
            let callVC = ViewControllerHelper.getViewController(ofType: .Organization)
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    else if(indexPath.row == 2){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Prefs")
//    }
//    else if(indexPath.row == 3){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Today's Feed")
//    }
//    else if(indexPath.row == 4){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Quran")
//    }
//    else if(indexPath.row == 5){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Community")
//    }
//    else if(indexPath.row == 6){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Settings")
//    }
//    else if(indexPath.row == 7){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Qiblah")
//
//    }
//    else if(indexPath.row == 8){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Quize")
//    }
//    else if(indexPath.row == 9){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Personnage")
//    }
//    else if(indexPath.row == 10){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Zakkat Calculator")
//    }
//    else if(indexPath.row == 12){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Haji")
//    }
//    else if(indexPath.row == 13){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Supplication")
//    }
//    else if(indexPath.row == 14){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Business")
//    }
//    else if(indexPath.row == 15){
//    self.dismiss(animated: true, completion: nil)
//    delegate?.CommonfunctionForSideMenuDelegate!(text:"Organization")
//    }
    
    func CommonfunctionForSideMenuDelegate(text:String)
    {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if text == "Login" {
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
        }
       else if text == "profile"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .ProfileVc)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
        }
           else if text == "Bookmark"{
                DispatchQueue.main.async {
                    let callVC = ViewControllerHelper.getViewController(ofType: .Bookmark)
                    
                    self.navigationController?.pushViewController(callVC, animated: true)
                }
            
        }
        else if text == "Donation"{
            DispatchQueue.main.async {
                let callVC:DonateVC  = ViewControllerHelper.getViewController(ofType: .donation) as! DonateVC
                callVC.mosqueid =   UserDefaults.standard.string(forKey: "mosque_id")!
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Prefs"{
            DispatchQueue.main.async {
//                let callVC = ViewControllerHelper.getViewController(ofType: .pre)
//                
//                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Today's Feed"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .feed)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Quran"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Quranlist)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Community"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .CommunityList)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Settings"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .settings)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Qiblah"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Qiblah)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Quize"{
            DispatchQueue.main.async {
              let callVC = ViewControllerHelper.getViewController(ofType: .Quiz)
                                                    // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                                    self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Personnage"{
            DispatchQueue.main.async {
               let callVC = ViewControllerHelper.getViewController(ofType: .personage)
                                       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                                       self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Zakkat Calculator"{
            DispatchQueue.main.async {
               
            }
            
        }
        else if text == "Haji"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Hajiumrah)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Supplication"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Supplication)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Business"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .business)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Organization"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Organization)
               
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
    }

}
