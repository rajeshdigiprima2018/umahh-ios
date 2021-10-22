//
//  FirstDonationVC.swift
//  Umahh
//
//  Created by mac on 16/06/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SwiftyJSON
import Braintree
import CRNotifications


class FirstDonationVC: UIViewController,UITextViewDelegate,UITextFieldDelegate{
    
    var braintreeClient: BTAPIClient?
    
      @IBOutlet var viewTotalAmount: UIView!
      @IBOutlet var txtNopeople: UITextField!
      @IBOutlet var lblAmount: UILabel!
     @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    
     @IBOutlet var lblTotalAmounttext: UILabel!
    
    @IBOutlet var lblPeople: UILabel!
     @IBOutlet var lblmethod: UILabel!
      @IBOutlet var txtname: UITextView!
      @IBOutlet var btnPaypal: UIButton!
      @IBOutlet var btnDonatenow: UIButton!
      @IBOutlet var nametextview: UIView!
    
    var strAmount = Int();
    var strFinalAmount = NSString();
     var donationArray = NSArray();
    
    var strcategoryid = NSString();
    var strmosqueid = NSString();

    override func viewDidLoad() {
        super.viewDidLoad()
        
          braintreeClient = BTAPIClient(authorization: "sandbox_x6b4gyj7_fs7wcjdxcmkvy3j2")!
        
          appDelegate.setRoundRectAndBorderColor(view: btnPaypal, color: UIColor.clear, width: 0.0, radious: 5.0)
        
         appDelegate.setRoundRectAndBorderColor(view: viewTotalAmount, color: UIColor.clear, width: 0.0, radious: 5.0)
        
       
        
        txtname.text = "Add Note"
        txtname.textColor = UIColor.white
        
        strAmount = 100
        self.donationApi()

        // Do any additional setup after loading the view.
    }
    func donationApi(){
        customLoader.show()
        
        
        
        kApiClass .shared .callAPI(WithType: .categorydonation, WithParams: [
            "dona_category_id":strcategoryid,
            "mosque_id":strmosqueid
            
            ], Success: { (response, isSuccess, error) in
                
                print(response!)
                
                
                
                
                let x  = response?.value(forKey: "success")  as! Int
                print(x)
                
                let getStatus = String(describing: x)
                print(getStatus)
                
                customLoader.hide()
                
                if getStatus == "1" {
                    
                    let swiftyJsonVar = JSON(response!)
                    print(swiftyJsonVar)
                    
                    self.donationArray = swiftyJsonVar["data"].arrayValue as NSArray
                    print(self.donationArray);
                    
                    if self.donationArray.count > 0 {
                    
                    
                    let data = self.donationArray[0] as! JSON
                    print(data)
                    
                    self.strAmount = (data["amount"].int)!
                    print(self.strAmount)
                    
                    self.lblAmount.text = "$ \(data["amount"].stringValue)"
                    
                 let title    = data["title"].stringValue
                    print(title)
                    
                    self.lblTitle.text = title
                    }
                    
                }
                else{
                    
                }
                
                
                
                
                
                
                
        }, Failure:{_,_,_ in
            customLoader.hide()
            
        })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
//        textField.selectedTextRange = textField.textRange(from:textField.beginningOfDocument, to: textField.endOfDocument)
        textField.selectAll(nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add Note" {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add Note"
            textView.textColor = UIColor.white
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtNopeople.text == "" {
            return
        }
        let peoplecount:Int? = Int(txtNopeople.text!)
        print(peoplecount!)
        let totalcount = peoplecount!*strAmount
        print(totalcount)
        
        let x : Int = totalcount
        
       
       
        
        strFinalAmount = "\(String(x))" as NSString
        
         print(strFinalAmount)
       
        
        lblTotalAmount.text = "$\(String(x))"
    }
    
    func setViews()
    {
        let title:String = UserDefaults.standard.object(forKey: "title") as! String
        print(title)
        
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
              print(dict)
          
              
             // btnPaypal.setTitle((dict["Done"]!), for: .normal)
               //btnPaypal.setTitle((dict["Khutba"]!), for: .normal)
              
              lblTotalAmounttext.text = (dict["Total_Donation_Amount"]!)
        lblTitle.text = (dict["donation_amount"]!)
        lblPeople.text = (dict["no_people"]!)
         lblmethod.text = (dict["Select_payment_method"]!)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func paymentBtn(_ sender: Any) {
        
        if lblTotalAmount.text == "" {
            
              CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Donation Amount", dismissDelay: 3)
            
            return
        }
        
        self.loadpaypal()
        
      
    }
    
     func loadpaypal()  {
        customLoader.show()
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
                          payPalDriver.viewControllerPresentingDelegate = self
                          payPalDriver.appSwitchDelegate = self
        let request = BTPayPalRequest(amount: strFinalAmount as String)
                          request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

                          payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                              if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                                  print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                                  // Access additional information
    //                              let email = tokenizedPayPalAccount.email
    //                              let firstName = tokenizedPayPalAccount.firstName
    //                              let lastName = tokenizedPayPalAccount.lastName
    //                              let phone = tokenizedPayPalAccount.phone
    //
    //                              // See BTPostalAddress.h for details
    //                              let billingAddress = tokenizedPayPalAccount.billingAddress
    //                              let shippingAddress = tokenizedPayPalAccount.shippingAddress
                                let transationid = tokenizedPayPalAccount.clientMetadataId
                                print(transationid!)
                                
                                //let creditFinancing = tokenizedPayPalAccount.creditFinancing
                                                           //print(creditFinancing!)
                                
                                let payerId = tokenizedPayPalAccount.payerId
                                                                                      print(payerId!)
                                
                                 customLoader.hide()
                                
                                 CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: "Thank you for Payment", dismissDelay: 3)
                                
                                let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                       self.navigationController?.pushViewController(callVC, animated: true)
                                
                                
                                
                                
                              } else if let error = error {
                                 print(error)
                                
                                 customLoader.hide()
                                
                                 CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Email", dismissDelay: 3)
                                
                              } else {
                                
                                 customLoader.hide()
                                  // Buyer canceled payment approval
                              }
                          }
              
        }
    
   

}
extension FirstDonationVC: BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
       
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension FirstDonationVC: BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
            }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
