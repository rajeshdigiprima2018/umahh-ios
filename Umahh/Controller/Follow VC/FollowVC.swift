//
//  FollowVC.swift
//  Umahh
//
//  Created by mac on 18/06/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRNotifications

class FollowVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblFollow: UITableView!
    
    var arrayfollow = NSArray();
     var strmosqueid = NSString();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblFollow.estimatedRowHeight = 55.0
        tblFollow.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
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
       let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
       print(dict)
       
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Following_Mosque"]!))
        
        tblFollow.register(UINib(nibName: "FollowMosqueCell", bundle: nil), forCellReuseIdentifier: "FollowMosqueCell")
        
        self.followListApi()
        
    }
    func followListApi(){
        customLoader.show()
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
        kApiClass .shared .callAPI(WithType: .followlist, WithParams: [
            "user_id": userid,
            
          
            
            
            
            
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
                        
                        let swiftyJsonVar = JSON(response!)
                        print(swiftyJsonVar)
                     
                        
                        
                        self.arrayfollow = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.arrayfollow);
                        
                        self.tblFollow.reloadData()
                        self.tblFollow.isHidden = false
                        
                    }
                    else {
                        self.tblFollow.isHidden = true
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayfollow.count
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowMosqueCell", for: indexPath) as! FollowMosqueCell
        
        
        let diccat = arrayfollow.object(at: indexPath.row) as! JSON
        
        print(diccat)
         print(diccat["createdAt"].stringValue)
        
        let content = diccat["mosque_id"].dictionary
//        print(content!)
        
        cell.lblMosquename.text = content!["username"]?.stringValue
     
        cell.lblmosqueaddress.text = content!["street_address"]?.stringValue
      
        let avtar : String =  "http://167.172.131.53:4002\(content!["avtar"]!.stringValue)"
        print(avtar)
        cell.imgMosque.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        cell.btnunFollow.setTitle((dict["Following_Mosque"]!), for: .normal)
        
        cell.btnunFollow.tag = indexPath.row
        cell.btnunFollow.addTarget(self, action: #selector(self.btnunFollowCall(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
     @objc func btnunFollowCall(_ sender: UIButton) {
        let diccat = arrayfollow.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        let content = diccat["mosque_id"].dictionary
        print(content!)
        
        
        strmosqueid =  content!["_id"]?.stringValue as! NSString
        print(strmosqueid)
        self.followApi()
    }
    
    func followApi(){
        
        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        customLoader.show()
        
        
        kApiClass .shared .callAPI(WithType: .addfollow, WithParams: [
            "mosque_id":strmosqueid,
            "user_id":userid,
            
            
            
            
            ], Success: { (response, isSuccess, error) in
                
                
                
                if isSuccess == true
                {
                    print("yes");
                    
                    print(response as AnyObject)
                    self.followListApi()
                    
                    
                    
                    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayfollow.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let content = diccat["mosque_id"].dictionary
        strmosqueid =  content!["_id"]?.stringValue as! NSString
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = strmosqueid as String
        
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
