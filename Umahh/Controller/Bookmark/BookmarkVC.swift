//
//  BookmarkVC.swift
//  Umahh
//
//  Created by mac on 18/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import SwiftyJSON

class BookmarkVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblBookmark: UITableView!
    
      var arrayBookmark = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblBookmark.estimatedRowHeight = 122.0
        tblBookmark.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
        self.bookmarkApi()
    }
    
    func bookmarkApi(){
        customLoader.show()
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
        kApiClass .shared .callAPI(WithType: .bookmarklist, WithParams: [
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
                        
                        self.arrayBookmark = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.arrayBookmark);
                        if(self.arrayBookmark.count == 0){
                            return
                        }
                        self.tblBookmark.reloadData()
                        self.tblBookmark.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblBookmark.isHidden = true
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    func setViews()
    {
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                   print(dict)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Bookmark"]! as! String))
        
        
        
        tblBookmark.register(UINib(nibName: "BookmarkCell", bundle: nil), forCellReuseIdentifier: "BookmarkCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBookmark.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 112
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as! BookmarkCell
        
        let diccat = arrayBookmark.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let content = diccat["supplication_id"].dictionary
        print(content!)
        
        cell.lblTitle.text = content!["title"]?.stringValue
        cell.lblDecription.text = content!["description"]?.stringValue
        cell.lblDestination.text = content!["description_aro"]?.stringValue
       
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
