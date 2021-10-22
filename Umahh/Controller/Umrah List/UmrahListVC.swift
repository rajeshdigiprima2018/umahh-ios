//
//  UmrahListVC.swift
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

class UmrahListVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArabic: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
     @IBOutlet weak var btnBookmark: UIButton!
    
      var strsupplicationid = NSString();

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
        
      
        
        let title:String = UserDefaults.standard.object(forKey: "supplication_title") as! String
        print(title)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
        
        let type:String = UserDefaults.standard.object(forKey: "loadtype") as! String
        print(type)
        if type == "Hajiumrah" {
             self.btnBookmark.isHidden = true
       
        self.hajiumrahdetailApi()
        }
        else {
            self.btnBookmark.isHidden = false
             let title:String = UserDefaults.standard.object(forKey: "supplication_title") as! String
            let eng_des:String = UserDefaults.standard.object(forKey: "supplication_desc_eng") as! String
            let arab_des:String = UserDefaults.standard.object(forKey: "supplication_desc_arab") as! String
            
            strsupplicationid = UserDefaults.standard.object(forKey: "supplication_id") as! String as NSString
            print(strsupplicationid)
            
            
            
            let content = eng_des
      let str = content.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
   let a = str.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
lblArabic.text = a
let content1 = arab_des
                              
                             // let content = "<p>&nbsp;&nbsp;test result</p><br/>"; // My String
                              
                       let str1 = content1.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                              
            let a1 = str1.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

                             lblEnglish.text = a1
            
            
            
            
            
            self.lblTitle.text = title
//            self.lblArabic.text = eng_des
//            self.lblEnglish.text = arab_des
        }
        
      
    }
    
    func hajiumrahdetailApi(){
        customLoader.show()
        
        
        
        let detailid:String = UserDefaults.standard.object(forKey: "detail_id") as! String
        print(detailid)
        
        
       
        
        
        let urlPath =  "http://167.172.131.53:4002/api/hajjumrah/get/\(detailid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                let dicdata = swiftyJsonVar["data"] as JSON
                print(dicdata)
                
                self.lblTitle.text = dicdata["title"].stringValue
               // self.lblArabic.text = dicdata["description_aro"].stringValue
              //  self.lblEnglish.text = dicdata["description"].stringValue
                
                let content = dicdata["description_aro"].stringValue
                                 
                                // let content = "<p>&nbsp;&nbsp;test result</p><br/>"; // My String
                                 
                          let str = content.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                                 
                          let a = str.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

                self.lblArabic.text = a
                          
                          let content1 = dicdata["description"].stringValue
                                            
                                           // let content = "<p>&nbsp;&nbsp;test result</p><br/>"; // My String
                                            
                                     let str1 = content1.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                                            
                          let a1 = str1.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

                self.lblEnglish.text = a1
                          
                          
                          
                          
                          
                      
               
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
     @IBAction func bookmarkClicked(_ sender: Any) {
        if btnBookmark.isSelected{
            btnBookmark.isSelected = false
        }
        else {
             btnBookmark.isSelected = true
        }
        self.supplicationbookmarkApi()
    }
    
    func supplicationbookmarkApi(){
        customLoader.show()
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
        kApiClass .shared .callAPI(WithType: .addbookmark, WithParams: [
            "supplication_id":strsupplicationid,
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
                        
                        
                        
                      
                            
                        }
                        else {
                        
                        }
                        
                        
                        
                    }
                    else {
                        customLoader.hide()
                        CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "", dismissDelay: 3)
                    }
                
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
//    func supplicationbookmarkApi(){
//        customLoader.show()
//
//
//
//
//
//
//
//
//
//        let urlPath =  "http://139.59.83.155:4002/api/supplication/get/\(strsupplicationid)"
//
//        print(urlPath)
//
//
//        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
//            response in
//            switch (response.result) {
//            case .success:
//                print(response)
//                let swiftyJsonVar = JSON(response.result.value!)
//                print(swiftyJsonVar)
//
//                let dicdata = swiftyJsonVar["data"] as JSON
//                print(dicdata)
//
//                self.lblTitle.text = dicdata["title"].stringValue
//                self.lblArabic.text = dicdata["description_aro"].stringValue
//                self.lblEnglish.text = dicdata["description"].stringValue
//
//
//
//                customLoader.hide()
//
//                break
//            case .failure:
//                customLoader.hide()
//                print(Error.self)
//            }
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
