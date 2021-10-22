//
//  SecondDonationVC.swift
//  Umahh
//
//  Created by mac on 26/07/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SwiftyJSON
import Braintree
import CRNotifications

class SecondDonationVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate  {
    
    var braintreeClient: BTAPIClient?
    
    @IBOutlet weak var TableDonation: UITableView!
     var donationArray = NSArray();
     var strcategoryid = NSString();
     var strmosqueid = NSString();
     var strtrasbcationid = NSString();
    
      var strtotalpayment = NSString();
     var strType = NSString();
      var finalAmount = Int();
     var totalAmount = NSString();
    
     var strFinalAmount = NSString();
    
     @IBOutlet weak var btnDone: UIButton!
     @IBOutlet weak var lblTotalAmount: UILabel!
     @IBOutlet weak var lblShowTotalAmount: UILabel!
     @IBOutlet weak var btnPaypal: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        finalAmount = 0
        strType = "no"
        
         braintreeClient = BTAPIClient(authorization: "sandbox_x6b4gyj7_fs7wcjdxcmkvy3j2")!
       
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
                    
                    
                    self.TableDonation.reloadData()
                    self.TableDonation.isHidden = false
                   
                }
                else{
                   
                }
                
                
                
                
                
                
                
        }, Failure:{_,_,_ in
            customLoader.hide()
           
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // PayPalMobile.preconnect(withEnvironment: environment)
         TableDonation.register(UINib(nibName: "SecondDonationCell", bundle: nil), forCellReuseIdentifier: "SecondDonationCell")
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    func setViews()
    {
        let title:String = UserDefaults.standard.object(forKey: "title") as! String
        print(title)
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        
        
        
        
        btnDone.setTitle((dict["Done"]!), for: .normal)
         //btnPaypal.setTitle((dict["Khutba"]!), for: .normal)
        
        lblTotalAmount.text = (dict["Total_Donation_Amount"]!)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return donationArray.count
       
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondDonationCell", for: indexPath) as! SecondDonationCell
            
            cell.selectionStyle = .none
           
        
        if strType == "yes" {
        
      let amount = Int(cell.txtPrice.text!)
            print(amount!)
          finalAmount = finalAmount + amount!
            print(finalAmount)
            totalAmount = String(finalAmount) as NSString
              lblShowTotalAmount.text = totalAmount as String
        }
        else {
            let diccat = donationArray.object(at: indexPath.row) as! JSON

                       print(diccat)

                   cell.lbltitle.text = diccat["title"].stringValue
                   cell.txtPrice.text =  diccat["amount"].stringValue
                   cell.txtPrice.delegate = self
                   cell.txtPrice.tag  = indexPath.row
        }
        
            return cell
            
     
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         let text = textField.text
           print(text!)
      
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
//        textField.selectedTextRange = textField.textRange(from:textField.beginningOfDocument, to: textField.endOfDocument)
        textField.selectAll(nil)
    }
    
     @IBAction func doneBtn(_ sender: Any) {
         finalAmount = 0
        strType = "yes"
        TableDonation.reloadData()
       // lblShowTotalAmount.text = totalAmount as String
    }

    
    @IBAction func paymentBtn(_ sender: Any) {
        if lblShowTotalAmount.text == "" {
                 
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
           let request = BTPayPalRequest(amount: totalAmount as String)
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
                                    self.strtrasbcationid = tokenizedPayPalAccount.clientMetadataId! as NSString
                                    print(self.strtrasbcationid)
                                   
                                   //let creditFinancing = tokenizedPayPalAccount.creditFinancing
                                                              //print(creditFinancing!)
                                   
                                   let payerId = tokenizedPayPalAccount.payerId
                                                                                         print(payerId!)
                                   
                                    self.makepaymentApi()
                                   
                                   
                                   
                                   
                                   
                                   
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
    
    func makepaymentApi(){
               customLoader.show()
               
               
               kApiClass .shared .callAPI(WithType: .makepayment, WithParams: [
                   "mosque_id":strmosqueid,
                   "txn_id":strtrasbcationid,
                    "amount":totalAmount,
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
                               
                          CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: "Thank you for Payment", dismissDelay: 3)
                                                            
                                                            let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                                                   self.navigationController?.pushViewController(callVC, animated: true)
                               
                               }
                               else {
                                     //CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Mosque/ Business users can access only web portal.", dismissDelay: 3)
                                   
                                   let alert = UIAlertController(title: Constant.Popup.Name, message: "Something went Wrong!", preferredStyle: .alert)
                                   
                                  alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                                   
                                   self.present(alert, animated: true)
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
    

}
extension SecondDonationVC: BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
       
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension SecondDonationVC: BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
            }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
