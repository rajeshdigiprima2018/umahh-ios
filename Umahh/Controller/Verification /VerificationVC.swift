//
//  VerificationVC.swift
//  Umahh
//
//  Created by mac on 11/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SVPinView
import CRNotifications

import Alamofire
import SwiftyJSON

class VerificationVC: UIViewController {
    
     @IBOutlet var pinView:SVPinView!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePinView()
        // Do any additional setup after loading the view.
    }
    
    func configurePinView() {
        
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.white
        pinView.borderLineColor = UIColor.red
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.style = .none
        //pinView.fieldBackgroundColor = UIColor.gray.withAlphaComponent(0.8)
        pinView.fieldBackgroundColor = UIColor(red: 120/256.0, green: 88/256.0, blue: 111/256.0, alpha: 1.0)
        pinView.activeFieldBackgroundColor = UIColor(red: 120/256.0, green: 88/256.0, blue: 111/256.0, alpha: 1.0)
        pinView.activeFieldCornerRadius = 5
        pinView.fieldCornerRadius = 5
        pinView.placeholder = "******"
        //pinView.becomeFirstResponderAtIndex = 0
        
        pinView.font = UIFont.systemFont(ofSize: 20)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(dismissKeyboard))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(pin:)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func didFinishEnteringPin(pin:String) {
        //showAlert(title: "Success", message: "The Pin entered is \(pin)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    func setViews()
    {
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "")
        
        
    }
    
    @IBAction func printPin() {
        
        
        
        let pin = pinView.getPin()
        
        guard !pin.isEmpty else {
            // showAlert(title: Constant.AppInfo.Name, message: "Please Enter Otp")
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Otp", dismissDelay: 3)
            
            return
        }
        print(pin)
        print(pin)
       
        
        
        
        let urlPath =  "http://167.172.131.53:4002/api/user/sendSmsOtpCheck/\(pin)"
        print(urlPath)
        
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                 CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: "Your Account Verify Sucessfully", dismissDelay: 3)
                
                let callVC = ViewControllerHelper.getViewController(ofType: .loginVC)
                self.navigationController?.pushViewController(callVC, animated: true)
               
                customLoader.hide()
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .selectmosque)
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
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
