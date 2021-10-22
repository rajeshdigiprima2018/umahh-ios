//
//  DonateVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DonateVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblDonate: UITableView!
    var arrayDonate = NSArray();
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Donation"]!))
        
          tblDonate.register(UINib(nibName: "DonationCell", bundle: nil), forCellReuseIdentifier: "DonationCell")
        
        self.donatelistApi()
    
    }
    
    func donatelistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
  
        
        let urlPath =  "http://167.172.131.53:4002/api/donation/category/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                
                self.arrayDonate = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayDonate);
                self.tblDonate.reloadData()
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDonate.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationCell", for: indexPath) as! DonationCell
        let diccat = arrayDonate.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        if indexPath.row == 0 {
           
            
            let imagurl = diccat["iconUrl"].stringValue
            print(imagurl)
            
            
            let profile : String =  "http://167.172.131.53:4002\(imagurl)"
            print(profile)
            cell.imgdonation.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "donation white"))
        }
        else {
            let imagurl = diccat["iconUrl"].stringValue
            print(imagurl)
            
            
            let profile : String =  "http://167.172.131.53:4002\(imagurl)"
            print(profile)
            cell.imgdonation.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "Zakat Al Fitr"))
        }
        
        cell.lblDonationame.text = diccat["title"].stringValue
        
        // if (diccat["pictures"].dictionary != nil) {
        
       
        
       
        
        
        
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      
        
        let diccat = arrayDonate.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        
        
          UserDefaults.standard.set(diccat["title"].stringValue, forKey: "title")
           
        if indexPath.row == 0 {
            let myViewController = SecondDonationVC(nibName: "SecondDonationVC", bundle: nil)
            myViewController.strcategoryid = diccat["dona_category_id"].stringValue as NSString
             myViewController.strmosqueid = diccat["mosque_id"].stringValue as NSString
            self.navigationController?.pushViewController(myViewController, animated: true)
        }
            
        
        else {
            //let callVC = ViewControllerHelper.getViewController(ofType: .specialdonate)
              let myViewController = FirstDonationVC(nibName: "FirstDonationVC", bundle: nil)
            myViewController.strcategoryid = diccat["dona_category_id"].stringValue as NSString
            myViewController.strmosqueid = diccat["mosque_id"].stringValue as NSString
            self.navigationController?.pushViewController(myViewController, animated: true)
            

            
            
            
        }
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func FirstDonateClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .specialdonate)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    @IBAction func SecondDonateClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .specialdonate)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
