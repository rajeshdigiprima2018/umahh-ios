//
//  BusinessOwnerSignupVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import Alamofire
import SwiftyJSON

class BusinessOwnerSignupVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMosquename: UITextField!
     @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtContactPersonname: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtstate: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    
    @IBOutlet weak var btnBusiness: UIButton!
    @IBOutlet weak var btnOrganization: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var PickerRegistration: UIPickerView!
    @IBOutlet weak var viewPicker: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    let picker1 = UIPickerView()
    var arrayCategory = NSArray();
     var arrayCountry = NSArray();
     var arrayState = NSArray();
     var arrayCity = NSArray();
    var strcategoryid = NSString();
     var strcountryid = NSString();
    var strstateiid = NSString();
    
    var strsendcountryid = NSString();
    var strsendCityid = NSString();
    var strsendstateiid = NSString();
    
    
     var strcityid = NSString();
     var straccountType = NSString();
    
    var strselecttype = NSString();
   
    var activeTextField = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                      print(dict)
        
        lblTitle.text = dict["Create_New_Account"]!
        lblSubtitle.text = dict["Enter_email_address_password_account"]!
               
         txtEmail.placeholder = dict["Enter Email"]!
         txtContactPersonname.placeholder = dict["Username"]!
         txtMosquename.placeholder = dict["Business_name"]!
         txtCategory.placeholder = dict["select_category"]!
         txtPhone.placeholder = dict["Enter_Phone_Number"]!
         txtCountry.placeholder = dict["select_country"]!
         txtstate.placeholder = dict["Select state"]!
         txtCity.placeholder = dict["select_city"]!
         txtStreet.placeholder = dict["street_Address"]!
         txtZip.placeholder = dict["zip_code"]!
        
        
         btnSignup.setTitle(dict["Register"]!, for: .normal)
         btnBusiness.setTitle(dict["Business"]!, for: .normal)
         btnOrganization.setTitle(dict["Organization"]!, for: .normal)
        
        btnBusiness.isSelected = true
        straccountType = "Business"
      

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btncategoryClick(_ sender: Any) {
        
        strselecttype = "1";
       
        self.view.endEditing(true)
     
        self.categorylistApi()
    }
    
    func categorylistApi(){
        customLoader.show()
        
        
        let urlPath = "http://167.172.131.53:4002/api/business/getAllCategory"
       
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCategory = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayCategory);
                self.PickerRegistration.selectRow(0, inComponent: 0, animated: true)
                self.PickerRegistration.reloadAllComponents()
                self.viewPicker.isHidden = false
                customLoader.hide()
                break
            case .failure:
                 customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func btncountryClick(_ sender: Any) {
        strselecttype = "2";
        self.view.endEditing(true)
        
        self.countrylistApi()
    }
    
    func countrylistApi(){
        customLoader.show()
        
        
        let urlPath = "http://167.172.131.53:4002/api/user/getCountries"

        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCountry = swiftyJsonVar["countries"].arrayValue as NSArray
                print(self.arrayCountry);
                 self.PickerRegistration.selectRow(0, inComponent: 0, animated: true)
                self.PickerRegistration.reloadAllComponents()
                self.viewPicker.isHidden = false
                customLoader.hide()
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func btnstateClick(_ sender: Any) {
        strselecttype = "3";
        self.view.endEditing(true)
        
        self.statelistApi()
    }
    
    func statelistApi(){
        customLoader.show()
       
        
       // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        let urlPath =  "http://167.172.131.53:4002/api/user/getStates/\(strcountryid)"
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayState = swiftyJsonVar["states"].arrayValue as NSArray
                print(self.arrayState);
                 self.PickerRegistration.selectRow(0, inComponent: 0, animated: true)
                self.PickerRegistration.reloadAllComponents()
                self.viewPicker.isHidden = false
                customLoader.hide()
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func btncityClick(_ sender: Any) {
        strselecttype = "4";
        self.view.endEditing(true)
        
        self.citylistApi()
    }
    
    func citylistApi(){
        customLoader.show()
        
        
        
        
        //let urlPath = "http://139.59.83.155:4002/api/user/getCities/42"
         let urlPath =  "http://167.172.131.53:4002/api/user/getCities/\(strstateiid)"
          print(urlPath)
        
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCity = swiftyJsonVar["states"].arrayValue as NSArray
                print(self.arrayCity);
                 self.PickerRegistration.selectRow(0, inComponent: 0, animated: true)
                self.PickerRegistration.reloadAllComponents()
                self.viewPicker.isHidden = false
                customLoader.hide()
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    
     @IBAction func businessClicked(_ sender: UIButton) {
       
            btnOrganization.isSelected = false;
            btnBusiness.isSelected = true;
             straccountType = "Business"
       
    }
    
    @IBAction func organzationClicked(_ sender: UIButton) {
        
            btnOrganization.isSelected = true;
            btnBusiness.isSelected = false;
             straccountType = "Organization"
        
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
    
    @IBAction func registerClicked(_ sender: Any) {
     
        if (txtMosquename.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Mosque Name", dismissDelay: 3)
            
        }
       
        else if (txtCategory.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Select Your Category", dismissDelay: 3)
            
        }
            
        else  if (txtPhone.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Phone Number", dismissDelay: 3)
        }
        else  if (txtContactPersonname.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Contact Person Name", dismissDelay: 3)
        }
        else  if (txtEmail.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Email", dismissDelay: 3)
        }
        else if !validateEmail(candidate: txtEmail.text!){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Valid Email", dismissDelay: 3)
        }
        else  if (txtCountry.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Select Your Country", dismissDelay: 3)
        }
        else  if (txtstate.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Select Your State", dismissDelay: 3)
        }
        else  if (txtCity.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Select Your City", dismissDelay: 3)
        }
        else  if (txtStreet.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Street Address", dismissDelay: 3)
        }
        else  if (txtZip.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Zip", dismissDelay: 3)
        }
        
        else {
            
            self.signupApi()
        }
    }
    
    func signupApi(){
        customLoader.show()
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
        
        let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
        
        
        kApiClass .shared .callAPI(WithType: .mosquebusiness_register, WithParams: [
            "email":txtEmail.text!,
            "nameContactPerson":txtContactPersonname.text!,
            "mobile":txtPhone.text!,
            "isFBUser":"false",
            "role": "business",
            "username":txtMosquename.text!,
            "businessType":straccountType,
            "street_address":txtStreet.text!,
            "category":strcategoryid,
            "country":"5c86215e0cb0e489af79ae49",
            "state":"5c861fa70cb0e489af798d80",
            "city":"5c8609610cb0e489af7837a1",
            "zipCode":txtZip.text!,
            "lat":latitude,
            "lng":longitude,
            
            
            
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
                        
                       // CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: "Thankyou for registering with Umahh. We will send you further details on mail after necessary verification and approval", dismissDelay: 3)
                        
                        let alert = UIAlertController(title: Constant.Popup.Name, message: "Thankyou for registering with Umahh. We will send you further details on mail after necessary verification and approval", preferredStyle: .alert)
                        
                       
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true)
                        
                        let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
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
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   




@objc func closePickerView()
{
    view.endEditing(true)
}


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if strselecttype == "1"{
        return arrayCategory.count
        }
        else if strselecttype == "2"{
             return arrayCountry.count
        }
        else if strselecttype == "3"{
             return arrayState.count
        }
        else {
            return arrayCity.count
        }
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if strselecttype == "1"{
            let diccat = arrayCategory.object(at: row) as! JSON
            print(diccat)
            strcategoryid = diccat["category_id"].stringValue as NSString
            print(strcategoryid)
            let categoryname  = diccat["name"].stringValue as NSString
            
            
            txtCategory?.text = diccat["name"].stringValue
             return categoryname as String
        }
        else if strselecttype == "2"{
            let diccat = arrayCountry.object(at: row) as! JSON
            print(diccat)
            strcountryid = diccat["id"].stringValue as NSString
            print(strcountryid)
            strsendcountryid = diccat["country_id"].stringValue as NSString
            let categoryname  = diccat["name"].stringValue as NSString
            
            
            txtCountry?.text = diccat["name"].stringValue
             return categoryname as String
        }
        else if strselecttype == "3" {
            let diccat = arrayState.object(at: row) as! JSON
            print(diccat)
            strstateiid = diccat["id"].stringValue as NSString
             strsendstateiid = diccat["state_id"].stringValue as NSString
            print(strcountryid)
            let categoryname  = diccat["name"].stringValue as NSString
            
            
            txtstate?.text = diccat["name"].stringValue
             return categoryname as String
        }
        else {
            let diccat = arrayCity.object(at: row) as! JSON
            print(diccat)
            strcityid = diccat["id"].stringValue as NSString
            print(strcityid)
            
             strsendCityid = diccat["state_id"].stringValue as NSString
            let categoryname  = diccat["name"].stringValue as NSString
            
            
            txtCity?.text = diccat["name"].stringValue
             return categoryname as String
        }

        
       
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
   
    @IBAction func btnDoneClick(_ sender: Any) {
        viewPicker.isHidden = true
    }
    @IBAction func btnCancelClick(_ sender: Any) {
        viewPicker.isHidden = true
    }

   

}


