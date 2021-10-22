//
//  BusinessDetailVC.swift
//  Umahh
//
//  Created by mac on 24/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import SwiftyJSON

class BusinessDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblBusinessDetail: UITableView!
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
        
        
        
        let title:String = UserDefaults.standard.object(forKey: "business_title") as! String
        print(title)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
        
        
        tblBusinessDetail.register(UINib(nibName: "BusniessDetailCell", bundle: nil), forCellReuseIdentifier: "BusniessDetailCell")
        self.supplicationlistApi()
    }
    
    func supplicationlistApi(){
        customLoader.show()
        let categoryid:String = UserDefaults.standard.object(forKey: "category_id") as! String
        print(categoryid)
        
        
        kApiClass .shared .callAPI(WithType: .businessdetail, WithParams: [
            "category_id": categoryid,
            "businessType": "business",
            
            
            
            
            
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
                        self.tblBusinessDetail.reloadData()
                        self.tblBusinessDetail.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblBusinessDetail.isHidden = true
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
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusniessDetailCell", for: indexPath) as! BusniessDetailCell
        let diccat = arraySupplication.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        cell.lblname.text = diccat["username"].stringValue
        cell.lbltext.text = diccat["street_address"].stringValue
        
        let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
        print(avtar)
        cell.imgProfile.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "user_default"))
       
        
        // cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arraySupplication.object(at: indexPath.row) as! JSON
        
        print(diccat)
         UserDefaults.standard.set(diccat["_id"].stringValue, forKey: "businessdetailid")
        
                let callVC = ViewControllerHelper.getViewController(ofType: .businessdetailfinal)
                self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
