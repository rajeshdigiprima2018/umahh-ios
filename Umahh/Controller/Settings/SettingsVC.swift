//
//  SettingsVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications

class SettingsVC: UIViewController {
    
    
     @IBOutlet weak var btnlogin: UIButton!
     @IBOutlet weak var btnNotification: UIButton!
     @IBOutlet weak var btnLang: UIButton!
     @IBOutlet weak var btnLangapp: UIButton!
     @IBOutlet weak var btnQuranTranslation: UIButton!
     @IBOutlet weak var btnPrayername: UIButton!
     @IBOutlet weak var btnterms: UIButton!
    
     var dictRoot: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            btnlogin.setTitle((dict["logout"]!), for: .normal)
        }
        
        else {
            btnlogin.setTitle((dict["login"]!), for: .normal)
           
        }

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
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                      print(dict)
        
        btnNotification.setTitle((dict["Notifications"]!), for: .normal)
        btnLang.setTitle((dict["Language"]!), for: .normal)
        btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
        btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
        btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
        btnterms.setTitle((dict["Terms_con"]!), for: .normal)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "Settings")
       
        
        
        
    }
    
    @IBAction func logoutbtnClicked(_ sender: Any) {
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        let alertController = UIAlertController(title: Constant.Popup.Name, message: "Are you sure want to logout?", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
            UserDefaults.standard.set(nil, forKey: "isLoggedIn")
            let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
            self.navigationController?.pushViewController(callVC, animated: true)
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "NO THANKS", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        }
        else {
            let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
            
            self.navigationController?.pushViewController(callVC, animated: true)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func langClicked(_ sender: Any) {
    let alert = UIAlertController(title: "", message: "Please Select Language", preferredStyle: .actionSheet)

           alert.addAction(UIAlertAction(title: "English" , style: .default , handler:{ (UIAlertAction)in
             if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                self.dictRoot = NSDictionary(contentsOfFile: path)
                        print(self.dictRoot!)
                        
                         print(self.dictRoot!["en"] as! NSDictionary)
                        
                        UserDefaults.standard.set(self.dictRoot!["en"] as! NSDictionary, forKey: "dict")
                                    let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                   print(dict)
                self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                self.btnLang.setTitle((dict["Language"]!), for: .normal)
                self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                    }
            let callVC = ViewControllerHelper.getViewController(ofType: .home)
                   self.navigationController?.pushViewController(callVC, animated: true)
           }))

           alert.addAction(UIAlertAction(title: "हिन्दी", style: .default , handler:{ (UIAlertAction)in
          if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                         self.dictRoot = NSDictionary(contentsOfFile: path)
                                 print(self.dictRoot!)
                                 
                                  print(self.dictRoot!["hin"] as! NSDictionary)
                                 
                                 UserDefaults.standard.set(self.dictRoot!["hin"] as! NSDictionary, forKey: "dict")
                                             let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                            print(dict)
            self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
            self.btnLang.setTitle((dict["Language"]!), for: .normal)
            self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
            self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
            self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
            self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                             }
            let callVC = ViewControllerHelper.getViewController(ofType: .home)
                   self.navigationController?.pushViewController(callVC, animated: true)
               
           }))
    
    alert.addAction(UIAlertAction(title: "اردو", style: .default , handler:{ (UIAlertAction)in
        
        if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                self.dictRoot = NSDictionary(contentsOfFile: path)
                                        print(self.dictRoot!)
                                        
                                         print(self.dictRoot!["urdu"] as! NSDictionary)
                                        
                                        UserDefaults.standard.set(self.dictRoot!["urdu"] as! NSDictionary, forKey: "dict")
                                                    let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                   print(dict)
                   self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                   self.btnLang.setTitle((dict["Language"]!), for: .normal)
                   self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                   self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                   self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                   self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                    }
                   let callVC = ViewControllerHelper.getViewController(ofType: .home)
                          self.navigationController?.pushViewController(callVC, animated: true)
    
         
     }))
    alert.addAction(UIAlertAction(title: "বাঙালি", style: .default , handler:{ (UIAlertAction)in
        
        
        if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                       self.dictRoot = NSDictionary(contentsOfFile: path)
                                               print(self.dictRoot!)
                                               
                                                print(self.dictRoot!["bang"] as! NSDictionary)
                                               
                                               UserDefaults.standard.set(self.dictRoot!["bang"] as! NSDictionary, forKey: "dict")
                                                           let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                          print(dict)
                          self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                          self.btnLang.setTitle((dict["Language"]!), for: .normal)
                          self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                          self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                          self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                          self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                           }
                          let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                 self.navigationController?.pushViewController(callVC, animated: true)
    
         
     }))
    
    alert.addAction(UIAlertAction(title: "Portuguese", style: .default , handler:{ (UIAlertAction)in
           
           
           if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                          self.dictRoot = NSDictionary(contentsOfFile: path)
                                                  print(self.dictRoot!)
                                                  
                                                   print(self.dictRoot!["Portuguese"] as! NSDictionary)
                                                  
                                                  UserDefaults.standard.set(self.dictRoot!["Portuguese"] as! NSDictionary, forKey: "dict")
                                                              let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                             print(dict)
                             self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                             self.btnLang.setTitle((dict["Language"]!), for: .normal)
                             self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                             self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                             self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                             self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                              }
                             let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                    self.navigationController?.pushViewController(callVC, animated: true)
       
            
        }))
    
    alert.addAction(UIAlertAction(title: "French", style: .default , handler:{ (UIAlertAction)in
              
              
              if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                             self.dictRoot = NSDictionary(contentsOfFile: path)
                                                     print(self.dictRoot!)
                                                     
                                                      print(self.dictRoot!["French"] as! NSDictionary)
                                                     
                                                     UserDefaults.standard.set(self.dictRoot!["French"] as! NSDictionary, forKey: "dict")
                                                                 let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                                print(dict)
                                self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                                self.btnLang.setTitle((dict["Language"]!), for: .normal)
                                self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                                self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                                self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                                self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                                 }
                                let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                       self.navigationController?.pushViewController(callVC, animated: true)
          
               
           }))
    
    alert.addAction(UIAlertAction(title: "Malay", style: .default , handler:{ (UIAlertAction)in
                 
                 
                 if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                                self.dictRoot = NSDictionary(contentsOfFile: path)
                                                        print(self.dictRoot!)
                                                        
                                                         print(self.dictRoot!["Malay"] as! NSDictionary)
                                                        
                                                        UserDefaults.standard.set(self.dictRoot!["Malay"] as! NSDictionary, forKey: "dict")
                                                                    let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                                   print(dict)
                                   self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                                   self.btnLang.setTitle((dict["Language"]!), for: .normal)
                                   self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                                   self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                                   self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                                   self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                                    }
                                   let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                          self.navigationController?.pushViewController(callVC, animated: true)
             
                  
              }))
    
    alert.addAction(UIAlertAction(title: "Catalan", style: .default , handler:{ (UIAlertAction)in
                    
                    
                    if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                                   self.dictRoot = NSDictionary(contentsOfFile: path)
                                                           print(self.dictRoot!)
                                                           
                                                            print(self.dictRoot!["Catalan"] as! NSDictionary)
                                                           
                                                           UserDefaults.standard.set(self.dictRoot!["Catalan"] as! NSDictionary, forKey: "dict")
                                                                       let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                                      print(dict)
                                      self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                                      self.btnLang.setTitle((dict["Language"]!), for: .normal)
                                      self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                                      self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                                      self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                                      self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                                       }
                                      let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                             self.navigationController?.pushViewController(callVC, animated: true)
                
                     
                 }))
    
    alert.addAction(UIAlertAction(title: "Español", style: .default , handler:{ (UIAlertAction)in
                       
                       
                       if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
                                                      self.dictRoot = NSDictionary(contentsOfFile: path)
                                                              print(self.dictRoot!)
                                                              
                                                               print(self.dictRoot!["Español"] as! NSDictionary)
                                                              
                                                              UserDefaults.standard.set(self.dictRoot!["Español"] as! NSDictionary, forKey: "dict")
                                                                          let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                                         print(dict)
                                         self.btnNotification.setTitle((dict["Notifications"]!), for: .normal)
                                         self.btnLang.setTitle((dict["Language"]!), for: .normal)
                                         self.btnLangapp.setTitle((dict["Language_App"]!), for: .normal)
                                         self.btnQuranTranslation.setTitle((dict["Quran_Translation"]!), for: .normal)
                                         self.btnPrayername.setTitle((dict["prayer_name"]!), for: .normal)
                                         self.btnterms.setTitle((dict["Terms_con"]!), for: .normal)
                                                          }
                                         let callVC = ViewControllerHelper.getViewController(ofType: .home)
                                                self.navigationController?.pushViewController(callVC, animated: true)
                   
                        
                    }))

          

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    
     @IBAction func quranlangClicked(_ sender: Any) {
       
            let alert = UIAlertController(title: "Umahh", message: "Please Select Quran Language", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Arabic", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button") 
                UserDefaults.standard.set("ar.abdulbasitmurattal", forKey: "quran_lang")
            }))

            alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
                 UserDefaults.standard.set("en.asad", forKey: "quran_lang")
            }))

            alert.addAction(UIAlertAction(title: "French", style: .default , handler:{ (UIAlertAction)in
                print("User click Delete button")
                
                UserDefaults.standard.set("fr.hamidullah", forKey: "quran_lang")
            }))

            alert.addAction(UIAlertAction(title: "Spanish", style: .default , handler:{ (UIAlertAction)in
                           print("User click Approve button")
                
                
                UserDefaults.standard.set("es.cortes", forKey: "quran_lang")
                
                       }))
        
        
           alert.addAction(UIAlertAction(title: "German", style: .default , handler:{ (UIAlertAction)in
                           print("User click Approve button")
            UserDefaults.standard.set("de.aburida", forKey: "quran_lang")
                       }))
        
           alert.addAction(UIAlertAction(title: "Pakistani", style: .default , handler:{ (UIAlertAction)in
                          print("User click Approve button")
             UserDefaults.standard.set("ur.ahmedali", forKey: "quran_lang")
                      }))

           
        
             alert.addAction(UIAlertAction(title: "Swahili", style: .default , handler:{ (UIAlertAction)in
                
                UserDefaults.standard.set("sw.barwani", forKey: "quran_lang")
                           print("User click Approve button")
                       }))
        
            alert.addAction(UIAlertAction(title: "Chinese", style: .default , handler:{ (UIAlertAction)in
                
                 UserDefaults.standard.set("zh.jian", forKey: "quran_lang")
                           print("User click Approve button")
                       }))
        
      
        
        alert.addAction(UIAlertAction(title: "Japanse", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            UserDefaults.standard.set("ja.japanese", forKey: "quran_lang")
            
        }))

             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                           print("User click Dismiss button")
                       }))
                   
           

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
   
      @IBAction func termsClicked(_ sender: Any) {
    let myViewController = TermsVC(nibName: "TermsVC", bundle: nil)
    self.navigationController?.pushViewController(myViewController, animated: true)}
}
