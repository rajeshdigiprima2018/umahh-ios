//
//  MosqueDetailVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON

class MosqueDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var tblMosqueDetail: UITableView!
    
    var strmosqueid = NSString();
    
    var email = NSString();
    var phone = NSString();
    var name = NSString();
    var address = NSString();
    var imgurl = NSString();
    var strFollowStatus = NSString();
    var strdescription = NSString();
    var likeuserarray = NSArray();
    @IBOutlet weak var btnFollow: UIButton!
    var mosqueid:String = ""
    var dict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
        print(dict)
        
        tblMosqueDetail.estimatedRowHeight = 295.0
        tblMosqueDetail.rowHeight = UITableViewAutomaticDimension
        
        //
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
        
    }
    
    func setViews()
    {
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "")
        
        tblMosqueDetail.register(UINib(nibName: "MosqueContentCell", bundle: nil), forCellReuseIdentifier: "MosqueContentCell")
        
        tblMosqueDetail.register(UINib(nibName: "MosqueOptionCell", bundle: nil), forCellReuseIdentifier: "MosqueOptionCell")
        
        self.mosqueDetailApi()
        
    }
    
    func mosqueDetailApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        //UserDefaults.standard.set(mosqueid, forKey: "mosque_id")
        
        
        
        
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
                
                let followdata = data["following_id"]
                
                print(followdata as AnyObject)
                
                self.email = data["email"].stringValue as NSString
                
                
                self.likeuserarray = followdata["followUser"].arrayValue as NSArray
                print(self.likeuserarray)
                
                
                self.strdescription = data["description_service"].stringValue as NSString
                
                let masquelat = data["lat"].stringValue as NSString
                
                let masquelong = data["lng"].stringValue as NSString
                
                print(masquelat)
                print(masquelong)
                
                UserDefaults.standard.set("\(masquelat)", forKey: "mosque_latitude")
                UserDefaults.standard.set("\(masquelong)", forKey: "mosque_longitude")
                
                
                
                
                self.phone = data["mobile"].stringValue as NSString
                
                
                self.name = data["username"].stringValue as NSString
                
                
                self.address = data["street_address"].stringValue as NSString
                
                
                
                self.imgurl = data["avtar"].stringValue as NSString
                
                
                
                
                self.tblMosqueDetail.reloadData()
                
                
                
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
        
        return 2
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MosqueContentCell", for: indexPath) as! MosqueContentCell
            
            
            cell.lblmosqueemail.text = email as String
            cell.lblmosquephone.text = phone as String
            cell.lblMosquename.text = name as String
            cell.lblmosqueaddress.text = address as String
            
            
            let htmlData = NSString(string: strdescription).data(using: String.Encoding.unicode.rawValue)
            
            let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            
            
            
            
            
            let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
            
            print(attributedString)
            
            
            
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
            
            
            cell.lblmosquedescription.attributedText = attributedString
            cell.lblmosquedescription.tintColor = UIColor.white
            
            
            
            let strimgurl  =  "http://167.172.131.53:4002\(imgurl)" as NSString
            
            cell.imgmosque.sd_setImage(with: URL(string: strimgurl as String), placeholderImage: UIImage(named: "mosque_default"))
            appDelegate.setRoundRectAndBorderColor(view:  cell.imgmosque, color: UIColor.clear, width: 0.0, radious:  cell.imgmosque.frame.size.height/2)
            
            cell.btnPrayer.addTarget(self, action: #selector(self.prayerClicked(_:)), for: .touchUpInside)
            cell.btnMap.addTarget(self, action: #selector(self.mapClicked(_:)), for: .touchUpInside)
            cell.btnFollowing.addTarget(self, action: #selector(self.followingClicked(_:)), for: .touchUpInside)
            cell.btnHomeMosque.addTarget(self, action: #selector(self.homeClicked(_:)), for: .touchUpInside)
            let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
            print(mosqueid)
            print(self.mosqueid )
          
            if(self.mosqueid == mosqueid)
            {
                cell.btnHomeMosque.backgroundColor = UIColor.gray
                
            }
            
            
            cell.btnMap.setTitle((dict["Map"]! as! String), for: .normal)
            
            cell.btnPrayer.setTitle((dict["Prayer_Schedule"]! as! String), for: .normal)
            cell.btnFollowing.setTitle((dict["follow"]! as! String), for: .normal)
            
            
            
            if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
            {
                
                let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
                print(userid)
                
                for  i in 0 ..< self.likeuserarray.count {
                    // self.selectInterestArray.add("0")
                    
                    print(i)
                    let strlikeuserid1 = self.likeuserarray[i] as! JSON
                    print(strlikeuserid1)
                    
                    let
                        strlikeuserid = strlikeuserid1.stringValue as NSString
                    print(strlikeuserid)
                    
                    
                    
                    
                    
                    
                    if strlikeuserid as String  == userid {
                        print("YES")
                        strFollowStatus = "YES"
                        cell.btnFollowing.setTitle((dict["Following"]! as! String), for: .normal)
                    }
                    else {
                        print("NO")
                        strFollowStatus = "No"
                        cell.btnFollowing.setTitle((dict["follow"]! as! String), for: .normal)
                    }
                }
            }
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MosqueOptionCell", for: indexPath) as! MosqueOptionCell
            
            cell.btnBoard.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnKhutba.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnCalendor.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnEducation.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnSuggestion.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnActivities.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnNews.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnAssociates.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            cell.btnDonation.addTarget(self, action: #selector(self.mosquemenuClicked(_:)), for: .touchUpInside)
            
            cell.lblBoard.text = (dict["Board"]! as! String)
            cell.lblKhutba.text = (dict["Khutba"]! as! String)
            cell.lblCalendor.text = (dict["Calendar"]! as! String)
            cell.lblEducation.text = (dict["Education"]! as! String)
            cell.lblSuggestion.text = (dict["Suggestions"]! as! String)
            cell.lblActivities.text = (dict["Activities"]! as! String)
            cell.lblNews.text = (dict["News"]! as! String)
            cell.lblAssociates.text = (dict["Associates"]! as! String)
            cell.lblDonation.text = (dict["Donation"]! as! String)
            
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func prayerClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .prayertime)
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    @objc func mapClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .mosqueMap)
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    @objc func followingClicked(_ sender: UIButton) {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            
            if strFollowStatus == "YES" {
                sender.setTitle("Follow", for: .normal)
                
                strFollowStatus = "No"
            }
            else {
                sender.setTitle("Following", for: .normal)
                strFollowStatus = "YES"
            }
            
            self.followApi()
        }
    }
    
    @objc func homeClicked(_ sender: UIButton) {
        selectmosqueApi()
        
    }
    
    func selectmosqueApi(){
          customLoader.show()
         let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
        kApiClass .shared .callAPI(WithType: .selectmosque, WithParams: [
            "user_id": userid,
            "isSelect": "true",
            "mosque_id": mosqueid
            
            ], Success: { (response, isSuccess, error) in
                
                if isSuccess == true
                {
                    print("yes");
                    
                    print(response as AnyObject)
                    
                    let x  = response?.value(forKey: "success")  as! Int
                    print(x)
                    
                    let getStatus = String(describing: x)
                    print(getStatus)
                    
                    
                    if getStatus == "1" {
                        
                        let diccat = JSON(response!)["data"] as! JSON
                        print(diccat)
//                        strmosqueid =
                         UserDefaults.standard.set(diccat["_id"].stringValue as NSString, forKey: "mosque_id")
                        UserDefaults.standard.set(diccat["username"].stringValue as NSString, forKey: "mosque_name")
                        UserDefaults.standard.set(diccat["street_address"].stringValue as NSString, forKey: "mosque_address")
                        CRNotifications.showNotification(type: CRNotifications.success, title: Constant.AppInfo.Name, message: "Home mosque set", dismissDelay: 3)
                        self.tblMosqueDetail.reloadData()
                    }
                    
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    func followApi(){
        
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        customLoader.show()
        
        
        kApiClass .shared .callAPI(WithType: .addfollow, WithParams: [
            "mosque_id":mosqueid,
            "user_id":userid,
            
            
            
            
        ], Success: { (response, isSuccess, error) in
            
            
            
            if isSuccess == true
            {
                print("yes");
                
                print(response as AnyObject)
                
                
                
                
                
                let x  = response?.value(forKey: "success")  as! Int
                print(x)
                
                let getStatus = String(describing: x)
                print(getStatus)
                
                
                let getmessage  = response?.value(forKey: "message")  as! NSString
                print(getmessage)
                let getmessagestr = String(describing: getmessage)
                print(getmessagestr)
                
                customLoader.hide()
                
            }
            
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    @objc func mosquemenuClicked(_ sender: UIButton) {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            
            print(sender.tag)
            if sender.tag == 0 {
                let callVC: BaordVC = ViewControllerHelper.getViewController(ofType: .board) as! BaordVC
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 1 {
                let callVC:KhutbaVC = ViewControllerHelper.getViewController(ofType: .khutba) as! KhutbaVC
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 2 {
                let callVC:CalendorVC = ViewControllerHelper.getViewController(ofType: .calendar) as! CalendorVC
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 3 {
                let callVC:EducationListVC = ViewControllerHelper.getViewController(ofType: .Edulist) as! EducationListVC
                callVC.mosqueid = mosqueid
               self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 4 {
                let callVC:SuggestionVC = ViewControllerHelper.getViewController(ofType: .suggestion) as! SuggestionVC
                callVC.mosqueid = mosqueid
               self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 5 {
                let callVC:ActivityList = ViewControllerHelper.getViewController(ofType: .activitiesList) as! ActivityList
                callVC.mosqueid = mosqueid
               self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 6 {
                let callVC:NewsList = ViewControllerHelper.getViewController(ofType: .newsList) as! NewsList
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            else if sender.tag == 7 {
                let callVC :AssociationList = ViewControllerHelper.getViewController(ofType: .assocation) as! AssociationList
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            else {
                
                let callVC:DonateVC = ViewControllerHelper.getViewController(ofType: .donation) as! DonateVC
                callVC.mosqueid = mosqueid
                self.navigationController?.pushViewController(callVC, animated: true)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

