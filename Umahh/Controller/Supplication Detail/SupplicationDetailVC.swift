//
//  SupplicationDetailVC.swift
//  Umahh
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import SwiftyJSON
import Alamofire

class SupplicationDetailVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblSupplicationDetaillist: UITableView!
    var arraySupplication = NSArray();
    var strid = NSString();
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        
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
                     appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Supplication"]!))
        
        
        tblSupplicationDetaillist.register(UINib(nibName: "ItemSupplicationCell", bundle: nil), forCellReuseIdentifier: "ItemSupplicationCell")
        
        let categoryid:String = UserDefaults.standard.object(forKey: "supCategory_id") as! String
        
        if categoryid == "All"{
            self.supplicationallApi()
        }
        else {
        self.supplicationlistApi()
        }
    }
    
    func supplicationallApi(){
        customLoader.show()
        
        
        
        
        
        
        let urlPath =  "http://167.172.131.53:4002/api/supplication/getAllCategory"
        
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arraySupplication = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arraySupplication);
                self.tblSupplicationDetaillist.reloadData()
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func supplicationlistApi(){
        customLoader.show()
        let categoryid:String = UserDefaults.standard.object(forKey: "supCategory_id") as! String
        print(categoryid)
        
        
        kApiClass .shared .callAPI(WithType: .supplicationdetail, WithParams: [
            "supCategory_id": categoryid,
            
            
            
            
            
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
                        
                        self.arraySupplication = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.arraySupplication);
                        if(self.arraySupplication.count == 0){
                            return
                        }
                        self.tblSupplicationDetaillist.reloadData()
                        self.tblSupplicationDetaillist.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblSupplicationDetaillist.isHidden = true
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
        return arraySupplication.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSupplicationCell", for: indexPath) as! ItemSupplicationCell
        let diccat = arraySupplication.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
         let categoryid:String = UserDefaults.standard.object(forKey: "supCategory_id") as! String
        
        if categoryid == "All"{
             cell.lblTitle.text = diccat["name"].stringValue
        }
        else {
        
        cell.lblTitle.text = diccat["title"].stringValue
            
        }
        print(indexPath.row+1)
        cell.lblindexno.text = "\(indexPath.row+1)"
        
        // cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let categoryid:String = UserDefaults.standard.object(forKey: "supCategory_id") as! String
        
        if categoryid == "All"{
            
            let callVC = ViewControllerHelper.getViewController(ofType: .Supplicationdetail)
            let diccat = arraySupplication.object(at: indexPath.row) as! JSON
            
            print(diccat)
            UserDefaults.standard.set("", forKey: "supCategory_id")
            UserDefaults.standard.set(diccat["supCategory_id"].stringValue, forKey: "supCategory_id")
             UserDefaults.standard.set(diccat["title"].stringValue, forKey: "supplication_title")
            
            self.navigationController?.pushViewController(callVC, animated: true)
            
        }
        else {
        
        let diccat = arraySupplication.object(at: indexPath.row) as! JSON
        
        print(diccat)
        UserDefaults.standard.set(diccat["title"].stringValue, forKey: "supplication_title")
         UserDefaults.standard.set(diccat["description_aro"].stringValue, forKey: "supplication_desc_arab")
         UserDefaults.standard.set(diccat["description"].stringValue, forKey: "supplication_desc_eng")
         UserDefaults.standard.set("Supplication", forKey: "loadtype")
            
             UserDefaults.standard.set(diccat["title"].stringValue, forKey: "supplication_title")
            
             UserDefaults.standard.set(diccat["supplication_id"].stringValue, forKey: "supplication_id")
            
        
                let callVC = ViewControllerHelper.getViewController(ofType: .hajiumrahdetailContent)
                self.navigationController?.pushViewController(callVC, animated: true)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
