//
//  SuggestionVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications

class SuggestionVC: UIViewController,UITextViewDelegate {
    
     @IBOutlet weak var txtsuggestion: UITextView!
    
      var dict = NSDictionary()
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
                                           print(dict)
        
        
        
        txtsuggestion.text = ((dict["Write_Message"]!) as! String)
        txtsuggestion.textColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == ((dict["Write_Message"]!) as! String) {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ((dict["Write_Message"]!) as! String)
            textView.textColor = UIColor.white
        }
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Suggestions"]!))
            setRightAddButton()
        
    }
    func setRightAddButton()
    {
        let addButton = UIButton(type: .custom)
       // addButton.setTitle("Add Now", for: .normal)
       // addButton.backgroundColor = appThemeColorGreen
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font =  UIFont(name: "SFUIDisplay-Medium", size: 13)
      
        addButton.setImage(UIImage(named: "send"), for: .normal)
       // appDelegate.setRoundRectAndBorderColor(view: addButton, color: UIColor.clear, width: 0.0, radious: 3.0)
        addButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        addButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: addButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
    }
    
    @objc func searchButtonPressed(){
        print("add clicked")
        
        if txtsuggestion.text == "Write Message"{
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Message", dismissDelay: 3)
        }
        else {
             self.suggestionApi()
        }
       
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
     @IBAction func postSuggestion(_ sender: Any) {
       
    }
    
    func suggestionApi(){
        
        let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
//        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        
        customLoader.show()
        
        
        kApiClass .shared .callAPI(WithType: .postsuggestion, WithParams: [
            "user_id":userid,
            "mosque_id":mosqueid,
            "text_suggestion":txtsuggestion.text!
            
            
            
            
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
                        
                        self.navigationController?.popViewController(animated:true)
                        
                        
                        
                        
//                        let callVC = ViewControllerHelper.getViewController(ofType: .home)
//                        self.navigationController?.pushViewController(callVC, animated: true)
//                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                        UserDefaults.standard.synchronize()
                        
                        
                        
                        
                        
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
