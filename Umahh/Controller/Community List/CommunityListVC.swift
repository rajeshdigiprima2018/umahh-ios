//
//  CommunityListVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CRNotifications

class CommunityListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblCommnuity: UITableView!
    var arrayCommunity = NSArray();
     var likeuserarray = NSArray();
     var strlikeuserid = NSString();
      var strcommunityid = NSString();
     @IBOutlet weak var viewAlltab: UIView!
     @IBOutlet weak var viewMinetab: UIView!
    
    @IBOutlet weak var btnAlltab: UIButton!
        @IBOutlet weak var btnMinetab: UIButton!
    
     var strType = NSString();

    override func viewDidLoad() {
        super.viewDidLoad()
        strType = "All"

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Community"]!))
        
        btnAlltab.setTitle((dict["All"]!), for: .normal)
        btnMinetab.setTitle((dict["Mine"]!), for: .normal)
        
         tblCommnuity.register(UINib(nibName: "CommunityCell", bundle: nil), forCellReuseIdentifier: "CommunityCell")
        
        tblCommnuity.register(UINib(nibName: "MyCommunityCell", bundle: nil), forCellReuseIdentifier: "MyCommunityCell")
        
        self.communitylistApi()
        
       
    }
    
    func communitylistApi(){
        customLoader.show()
       strType = "All"
        
        
       
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
      let urlPath =  "http://167.172.131.53:4002/api/user/Community/getAllList/"
      
        
       // let urlPath =  "http://139.59.83.155:4002/api/user/Community/getAll/\(userid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCommunity = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayCommunity);
                self.tblCommnuity.reloadData()
                
                
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
        return arrayCommunity.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if strType == "All" {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell", for: indexPath) as! CommunityCell
        let diccat = arrayCommunity.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        let likecommunity = diccat["likecommunity_id"]
        print(likecommunity)
            
            //let likeCount = likecommunity["likeCounter"].stringValue
            //print(likeCount)
            
            let likecount =  "\(likecommunity["likeCounter"].stringValue) Make Dua"
            cell.btnnoLike.setTitle(likecount, for: .normal)
            cell.lbltext.text = diccat["description"].stringValue
        
        likeuserarray = likecommunity["likeUser"].arrayValue as NSArray
        print(likeuserarray)
        
        for  i in 0 ..< self.likeuserarray.count {
            // self.selectInterestArray.add("0")
            
            print(i)
           let strlikeuserid1 = self.likeuserarray[i] as! JSON
            print(strlikeuserid1)
            
            strlikeuserid = strlikeuserid1.stringValue as NSString
            print(strlikeuserid)
            

            
            
            
            
            if strlikeuserid as String  == userid {
                print("YES")
                cell.btnLike.isSelected = true
            }
            else {
                  print("NO")
                  cell.btnLike.isSelected = false
            }
            
        }
        }
       
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(self.btnLikeCall(_:)), for: .touchUpInside)
        
        
        
      
        
        cell.selectionStyle = .none
             return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommunityCell", for: indexPath) as! MyCommunityCell
            let diccat = arrayCommunity.object(at: indexPath.row) as! JSON
            
            print(diccat)
            
            if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
            {
                
                let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
                print(userid)
                
                let likecommunity = diccat["likecommunity_id"]
                print(likecommunity)
                
                //let likeCount = likecommunity["likeCounter"].stringValue
                //print(likeCount)
                
                let likecount =  "\(likecommunity["likeCounter"].stringValue) Make Dua"
                cell.btnnoLike.setTitle(likecount, for: .normal)
                cell.lbltext.text = diccat["description"].stringValue
                
                likeuserarray = likecommunity["likeUser"].arrayValue as NSArray
                print(likeuserarray)
                
                for  i in 0 ..< self.likeuserarray.count {
                    // self.selectInterestArray.add("0")
                    
                    print(i)
                    let strlikeuserid1 = self.likeuserarray[i] as! JSON
                    print(strlikeuserid1)
                    
                    strlikeuserid = strlikeuserid1.stringValue as NSString
                    print(strlikeuserid)
                    
                    
                    
                    
                    
                    
                    if strlikeuserid as String  == userid {
                        print("YES")
                        cell.btnLike.isSelected = true
                    }
                    else {
                        print("NO")
                        cell.btnLike.isSelected = false
                    }
                    
                }
            }
            
            cell.btnLike.tag = indexPath.row
            cell.btnLike.addTarget(self, action: #selector(self.btnLikeCall(_:)), for: .touchUpInside)
            
            
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(self.btnDeleteCall(_:)), for: .touchUpInside)
            
            
            cell.selectionStyle = .none
             return cell
        }
       
    }
    
     @objc func btnDeleteCall(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            let diccat = arrayCommunity.object(at: sender.tag) as! JSON
            
            print(diccat)
            
            
            strcommunityid =  diccat["community_id"].stringValue as NSString
            print(strcommunityid)
            
            self.deleteApi()
        }
    }
    
    func deleteApi(){
        
        let firstTodoEndpoint: String = "http://167.172.131.53:4002/api/user/Community/delete/\(strcommunityid)"
        Alamofire.request(firstTodoEndpoint, method: .delete)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling DELETE on /todos/1")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                print("DELETE ok")
                 self.communitymylistApi()
                
        }
        
//        customLoader.show()
//
//        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
//        print(userid)
//
//
//
//
//
//        kApiClass .shared .callAPI(WithType: .communitydelete, WithParams: [
//            "community_id":strcommunityid,
//            "user_id":userid,
//
//
//
//
//            ], Success: { (response, isSuccess, error) in
//
//
//
//                if isSuccess == true
//                {
//                    print("yes");
//
//                    print(response as AnyObject)
//
//
//
//
//
//                    let x  = response?.value(forKey: "success")  as! Int
//                    print(x)
//
//                    let getStatus = String(describing: x)
//                    print(getStatus)
//
//
//                    let getmessage  = response?.value(forKey: "message")  as! NSString
//                    print(getmessage)
//                    let getmessagestr = String(describing: getmessage)
//                    print(getmessagestr)
//
//                    customLoader.hide()
//
//                    if getStatus == "1" {
//
//                        self.communitylistApi()
//
//
//
//
//
//                    }
//                    else {
//                        customLoader.hide()
//                        CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: getmessage as String, dismissDelay: 3)
//                    }
//                }
//
//        }, Failure:{_,_,_ in
//
//            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
//        })
    }
    
     @objc func btnLikeCall(_ sender: UIButton) {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        let diccat = arrayCommunity.object(at: sender.tag) as! JSON
        
        print(diccat)
        
      
        strcommunityid =  diccat["community_id"].stringValue as NSString
        print(strcommunityid)
       
     self.communitymylikeApi()
        }
        
        
    }
    
    func communitymylikeApi(){
        customLoader.show()
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
       
        
        
        kApiClass .shared .callAPI(WithType: .communitylike, WithParams: [
            "community_id":strcommunityid,
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
                    
                    if getStatus == "1" {
                        
                     self.communitylistApi()
                        
                        
                        
                        
                        
                    }
                    else {
                        customLoader.hide()
                        CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: getmessage as String, dismissDelay: 3)
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    @IBAction func clicktabClicked(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        if sender.tag == 0{
            viewMinetab.isHidden = true
            viewAlltab.isHidden = false
            self.communitylistApi()
        }
        else {
            viewMinetab.isHidden = false
            viewAlltab.isHidden = true
            self.communitymylistApi()
        }
        }
        
       
    }
    func communitymylistApi(){
        customLoader.show()
        
        strType = "my"
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
       

        
        
        let urlPath =  "http://167.172.131.53:4002/api/user/Community/getAll/\(userid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCommunity = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayCommunity);
                self.tblCommnuity.reloadData()
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addCoummnityClicked(_ sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            let callVC = ViewControllerHelper.getViewController(ofType: .addCommnunity)
            self.navigationController?.pushViewController(callVC, animated: true)
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
