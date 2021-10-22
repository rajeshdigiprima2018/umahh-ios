//
//  ForgetVc.swift
//  Umahh
//
//  Created by mac on 13/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import SwiftyJSON

class ForgetVc: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lbltitle: UILabel!
       
    @IBOutlet weak var btnsubmit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                      print(dict)
               
                txtEmail.placeholder = dict["Enter Email"]!
                lbltitle.text = dict["Please_register_email."]!
           
                btnsubmit.setTitle(dict["submit"]!, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    func setViews()
    {
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: dict["Forget_Password"]!)
        
        
    }
    @IBAction func forgetPasswordClicked(_ sender: Any) {
        
        
        
        
        
        
        if (txtEmail.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Email", dismissDelay: 3)
            
        }
        else if !validateEmail(candidate: txtEmail.text!){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Valid Email", dismissDelay: 3)
        }
       
            
            
        else {
            
            self.forgetpasswordApi()
        }
    }
    
    func forgetpasswordApi(){
        customLoader.show()
        
        
        kApiClass .shared .callAPI(WithType: .forgetPassword, WithParams: [
            "email":txtEmail.text!,
            "action":"forgot_password",
            "locale":"en",
           
            
            
            
            
            ], Success: { (response, isSuccess, error) in
                
                
                
                if isSuccess == true
                {
                    print("yes");
                    
                    print(response as AnyObject)
                    
                    
                    
                    
                    
                    let x  = response?.value(forKey: "success")  as! Int
                    print(x)
                    
                    let getStatus = String(describing: x)
                    print(getStatus)
                    
                
                    
                    
                   
                    
                    customLoader.hide()
                    
                    if getStatus == "1" {
                        let getmessage  = response?.value(forKey: "message")  as! NSString
                        print(getmessage)
                        let getmessagestr = String(describing: getmessage)
                        print(getmessagestr)
                        
                        CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: getmessage as String, dismissDelay: 3)
                        
                        
                      self.navigationController?.popViewController(animated:true)
                        
                        
                        
                        
                        
                    }
                    else {
                        let getmessage  = response?.value(forKey: "error")  as! NSString
                        print(getmessage)
                        let getmessagestr = String(describing: getmessage)
                        print(getmessagestr)
                        customLoader.hide()
                        CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: getmessage as String, dismissDelay: 3)
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
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
