//
//  SignupVC.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import CoreLocation

class SignupVC: UIViewController, UITextFieldDelegate,GIDSignInDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
     @IBOutlet weak var txtUsername: UITextField!
     @IBOutlet weak var txtPhone: UITextField!
     @IBOutlet weak var txtPassword: UITextField!
     @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var socialData:NSDictionary = [:]
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var lblor: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
     @IBOutlet weak var btnsignupfb: UIButton!
     @IBOutlet weak var btnsignupgm: UIButton!
      
    
     var iconClick = true
    var iconPaswordClick = true

    override func viewDidLoad() {
        super.viewDidLoad()
      
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
               print(dict)
        
         txtEmail.placeholder = dict["Enter Email"]!
        txtUsername.placeholder = dict["Username"]!
        txtPassword.placeholder = dict["Password"]!
        txtPhone.placeholder = dict["Enter_Phone"]!
        txtConfirmPassword.placeholder = dict["Confirm_Password"]!
               
                 lblTitle.text = dict["Signup"]!
                lbltext.text = dict["By_agree_term_conditions"]!
                lblor.text = dict["Or_Sign_up_with"]!
        
         btnRegister.setTitle(dict["Register"]!, for: .normal)
         btnsignupfb.setTitle(dict["Signup_Facebook"]!, for: .normal)
         btnsignupgm.setTitle(dict["Signup_Gmail"]!, for: .normal)
               
               

        // Do any additional setup after loading the view.
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
        
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
      
        
        if (txtEmail.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Email", dismissDelay: 3)
            
        }
        else if !validateEmail(candidate: txtEmail.text!){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Valid Email", dismissDelay: 3)
        }
        else if (txtPassword.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please Enter Your Password", dismissDelay: 3)
            
        }
       
        else  if (txtConfirmPassword.text == ""){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Your Confirm Password", dismissDelay: 3)
        }
        else  if (txtPassword.text != txtConfirmPassword.text){
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "Please Enter Same Password", dismissDelay: 3)
        }
        else {
            
            self.signupApi()
        }
    }
    
    func signupApi(){
        customLoader.show()
        
       let token:String = UserDefaults.standard.object(forKey: "token") as! String
                  print(token)
        kApiClass .shared .callAPI(WithType: .user_register, WithParams: [
            "email":txtEmail.text!,
            "username":txtUsername.text!,
            "password":txtPassword.text!,
            "mobile":txtPhone.text!,
            "isFBUser":"false",
            "role":"user",
            "deviceToken":token,
            "deviceType":"ios",
           
            
            
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
                        
                       
                     //  let callVC = ViewControllerHelper.getViewController(ofType: .verificationVC)
                     //  self.navigationController?.pushViewController(callVC, animated: true)
                        
                        let callVC = ViewControllerHelper.getViewController(ofType: .loginVC)
                        self.navigationController?.pushViewController(callVC, animated: true)
                        
                       // UserDefaults.standard.set(true, forKey: "isLoggedIn")
                       // UserDefaults.standard.synchronize()
                        
                        
                        
                        
                        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func passwordClicked(_ sender: Any) {
        
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func confirmpasswordClicked(_ sender: Any) {
        
        if(iconPaswordClick == true) {
            txtConfirmPassword.isSecureTextEntry = false
        } else {
            txtConfirmPassword.isSecureTextEntry = true
        }
        
        iconPaswordClick = !iconPaswordClick
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loginApiFB(email:String, fbtoken: String){
        customLoader.show()
    
        let token:String = UserDefaults.standard.object(forKey: "token") as! String
        print(token)
       
        kApiClass .shared .callAPI(WithType: .loginFB, WithParams: [
            "email":email,
            "accesstoken":fbtoken,
            "provider":"facebook",
            "deviceToken":token,
            "deviceType":"ios",
            ], Success: { (response, isSuccess, error) in
               
                    self.LoginResponseGF(response: response!,isSuccess: isSuccess)
                
                
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    func loginApiGoogle(email:String, fbtoken: String){
        customLoader.show()
    
        let token:String = UserDefaults.standard.object(forKey: "token") as! String
        print(token)
        
        kApiClass.shared.callAPI(WithType: .loginGoogle, WithParams: [
             "email":email,
                       "accesstoken":fbtoken,
                       "provider":"google",
                       "deviceToken":token,
                       "deviceType":"ios",
            ], Success: { (response, isSuccess, error) in
                
                self.LoginResponseGF(response: response!,isSuccess: isSuccess)
                
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    func LoginResponseGF(response : NSDictionary, isSuccess: Bool){
        if isSuccess == true
        {
            print("yes");
            
            print(response as AnyObject)
            
            let x  = response.value(forKey: "success")  as! Int
            print(x)
            
            let getStatus = String(describing: x)
            print(getStatus)
            
        
            
            customLoader.hide()
            
            if getStatus == "1" {
                
                
                
                let data = response.value(forKey: "data")as! NSDictionary
                
                print(data as AnyObject)
                
              
                    
                    let userid = data.value(forKey: "user_id")as! NSString
                    print(userid)
                    
                    UserDefaults.standard.set(userid, forKey: "user_id")
                    
                    let email = data.value(forKey: "email")as! NSString
                    print(email)
                    
                    UserDefaults.standard.set(email, forKey: "email")
                    
                    let access_token = data.value(forKey: "access_token")as! NSString
                    print(access_token)
                    
                    UserDefaults.standard.set(access_token, forKey: "access_token")
                    
                    
                    if (data.value(forKey: "username")as? NSString != nil) {
                        
                        let nameContactPerson = data.value(forKey: "username")as! NSString
                        print(nameContactPerson)
                        
                        UserDefaults.standard.set(nameContactPerson, forKey: "nameContactPerson")
                    }
                    else {
                        UserDefaults.standard.set("", forKey: "nameContactPerson")
                    }
                    
                    if (data.value(forKey: "avtar")as? NSString != nil) {
                        
                        let avtar = data.value(forKey: "avtar")as! NSString
                        print(avtar)
                        
                        UserDefaults.standard.set(avtar, forKey: "avtar")
                    }
                    else {
                        UserDefaults.standard.set("", forKey: "avtar")
                    }
                    
                    if (data.value(forKey: "mosque_id")as? NSString != nil) {
                        
                        let mosqueid = data.value(forKey: "mosque_id")as! NSString
                        print(mosqueid)
                        
                        UserDefaults.standard.set(mosqueid, forKey: "mosque_id")
                    }
                    else {
                        
                        UserDefaults.standard.set("", forKey: "mosque_id")
                    }
                    
                    CRNotifications.showNotification(type: CRNotifications.success, title: Constant.Popup.Name, message: "Successful login", dismissDelay: 3)
                    
                    
                    // CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: getmessagestr as String, dismissDelay: 3)
                    
                    let callVC = ViewControllerHelper.getViewController(ofType: .selectmosque)
                    self.navigationController?.pushViewController(callVC, animated: true)
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.synchronize()
                    
              
        
                
            }
            else {
                customLoader.hide()
                CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Error in login", dismissDelay: 3)
            }
        }
        
    }
   
    
    @IBAction func facebookClicked(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData(toekn: fbloginresult.token!.tokenString)
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(toekn: String){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //                    self.dict = result as! [String : AnyObject] as! [String : NSDictionary]
                    //                    print(result!)
                    //                    print(self.dict)
                    
                    self.socialData  =  result as! NSDictionary
                    
                    print(self.socialData)
                    
                    let userID = self.socialData["id"] as! NSString
                    
                    print(userID)
                    
                    let SocialUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                    print(SocialUrl)
                    
                    let SocialEmail = (self.socialData.value(forKey: "email") as! NSString) as String
                    print(SocialEmail);
                    
                    let SocialName = (self.socialData.value(forKey: "name") as! NSString) as String
                    print(SocialName);
                    print(toekn)
                    //SocialUrl
                    
                    self.loginApiFB(email: SocialEmail, fbtoken: toekn)
                              // self.Socialself.SignupApi()
                    // UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                }
            })
        }
    }
    
    @IBAction func googlePlusButtonTouchUpInside(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().delegate=self
        // GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        
    }
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID
            // For client-side use only!
            print(userId! as NSString)
            let idToken = user.authentication.idToken // Safe to send to the server
            print(idToken! as NSString)
            let fullName = user.profile.name
            print(fullName! as NSString)
            let givenName = user.profile.givenName
            print(givenName! as NSString)
            let familyName = user.profile.familyName
            print(familyName! as NSString)
            let email = user.profile.email
            print(email! as NSString)
            
            var SocialName = user.profile.name
            
            print(SocialName)
            
            var SocialEmail: String = user.profile.email
            
            print(SocialEmail)
            
            self.loginApiGoogle(email: SocialEmail, fbtoken: idToken!)
            
            
            
        } else {
            
        }
    }

}
