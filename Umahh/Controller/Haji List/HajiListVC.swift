//
//  HajiListVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRNotifications
import SDWebImage

class HajiListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblHajiumrahDetaillist: UITableView!
    var arrayHajiumrah = NSArray();
    var strid = NSString();
     @IBOutlet weak var imgDetail: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.setRoundRectAndBorderColor(view: imgDetail, color: UIColor.clear, width: 0.0, radious: 3.0)
       
       
        
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
        
        let img_url = UserDefaults.standard.object(forKey: "img_url") as! String
         imgDetail.sd_setImage(with: URL(string: img_url), placeholderImage: UIImage(named: "default.png"))
        
         let title = UserDefaults.standard.object(forKey: "haziumrahtitle") as! String
        
      
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
        
        
        tblHajiumrahDetaillist.register(UINib(nibName: "ItemSupplicationCell", bundle: nil), forCellReuseIdentifier: "ItemSupplicationCell")
        self.hajiumrahlistApi()
    }
    
    func hajiumrahlistApi(){
        customLoader.show()
        let hajiumrahid:String = UserDefaults.standard.object(forKey: "hajjumrahCategory_id") as! String
        print(hajiumrahid)
        
        
        kApiClass .shared .callAPI(WithType: .hajiumrahdetail, WithParams: [
            "hajjumrahCategory_id": hajiumrahid,
           
            
            
            
            
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
                        
                        self.arrayHajiumrah = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.arrayHajiumrah);
                        if(self.arrayHajiumrah.count == 0){
                            return
                        }
                        self.tblHajiumrahDetaillist.reloadData()
                        self.tblHajiumrahDetaillist.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblHajiumrahDetaillist.isHidden = true
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
        return arrayHajiumrah.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSupplicationCell", for: indexPath) as! ItemSupplicationCell
        let diccat = arrayHajiumrah.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        cell.lblTitle.text = diccat["title"].stringValue
        print(indexPath.row+1)
        cell.lblindexno.text = "\(indexPath.row+1)"
        
        // cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayHajiumrah.object(at: indexPath.row) as! JSON
        
        print(diccat)
         print(diccat["id"].stringValue)
       UserDefaults.standard.set(diccat["id"].stringValue, forKey: "detail_id")
        
         UserDefaults.standard.set("Hajiumrah", forKey: "loadtype")
         UserDefaults.standard.set("", forKey: "supplication_title")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .hajiumrahdetailContent)
        self.navigationController?.pushViewController(callVC, animated: true)
}
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
