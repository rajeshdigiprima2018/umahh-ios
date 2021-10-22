//
//  AddNewRequest.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications

class AddNewRequest: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var txtRequest: UITextView!
    
      @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnpost: UIButton!
     var dict = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
                      print(dict)
        lblTitle.text =  (dict["New_Request"]!) as? String
        btnpost.setTitle((dict["Post"]! as! String), for: .normal)
        
        txtRequest.text = (dict["Enter_your_request"]!) as? String
        txtRequest.textColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == (dict["Enter_your_request"]!) as? String {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = (dict["Enter_your_request"]!) as? String
            textView.textColor = UIColor.white
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func postSuggestion(_ sender: Any) {
        if txtRequest.text == "Enter your request" {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Text", dismissDelay: 3)
            return
        }
        self.requestApi()
    }
    
    func requestApi(){
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
       
        
        customLoader.show()
        
        
        kApiClass .shared .callAPI(WithType: .communityadd, WithParams: [
            "user_id":userid,
            "description":txtRequest.text!
            
            
            
            
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
                        
                        CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: getmessage as String, dismissDelay: 3)
                        
                        
                        
                        
                        
                        
                        let callVC = ViewControllerHelper.getViewController(ofType: .home)
                        self.navigationController?.pushViewController(callVC, animated: true)
                      
                      
                        
                        
                        
                        
                        
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

