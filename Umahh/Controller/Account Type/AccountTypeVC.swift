//
//  AccountTypeVC.swift
//  Umahh
//
//  Created by mac on 11/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AccountTypeVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblManager: UILabel!
    
     @IBOutlet weak var btnContinue: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        
          lblTitle.text = dict["I_am_a"]!
         lblUser.text = dict["User"]!
         //lblOwner.text = dict["Business_Owner"]!
         lblManager.text = dict["Mosque_Manager"]!
        
          btnContinue.setTitle(dict["Continue"]!, for: .normal)
        
        
        

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
    
    @IBAction func userAccountClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .signupVC)
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
    }
    
    @IBAction func ownerAccountClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .buss_ownersignup)
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
    }
    
    @IBAction func managerAccountClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .mosqueAccount)
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
