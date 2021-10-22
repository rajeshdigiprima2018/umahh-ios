//
//  MosquelistVC.swift
//  Umahh
//
//  Created by mac on 16/06/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON


class MosquelistVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var TableViewmosque: UITableView!
    let locationManager = CLLocationManager()
    @IBOutlet var txtSearch: UITextField!
    var searchArray = NSArray();
    var strmosqueid = NSString();
    @IBOutlet var tblSearchpop: UITableView!
    @IBOutlet var viewselectmosque: UIView!
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet var viewselectbg: UIView!
    
//    @IBOutlet weak var lblMosquename: UILabel!
//    @IBOutlet weak var lblmosqueaddress: UILabel!
//    @IBOutlet weak var imgSelectmos: UIImageView!
    
    var arrayMosque = NSArray();
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        
        if mosqueid == ""{
            heightconstraint.constant = 0
            viewselectmosque.layoutIfNeeded()
            viewselectbg.isHidden =  true
        }
        }
        else {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
            self.navigationController?.popViewController(animated:true)
        }
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if txtSearch.text == "" {
            tblSearchpop.isHidden = true
            return
        }
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        self.searchApi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
        
    }
    
    func setViews()
    {
       
        
        TableViewmosque.register(UINib(nibName: "SelMosqueCell", bundle: nil), forCellReuseIdentifier: "SelMosqueCell")
        tblSearchpop.register(UINib(nibName: "SelMosqueCell", bundle: nil), forCellReuseIdentifier: "SelMosqueCell")
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        self.mosquelistApi()
        }
    }
    
    func mosquelistApi(){
        customLoader.show()
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
        
        let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        let urlPath =  "http://167.172.131.53:4002/api/mosque/nearby/\(latitude)/\(longitude)/\("10000")"
      
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayMosque = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayMosque);
                self.TableViewmosque.reloadData()
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
        if tableView == tblSearchpop {
            return searchArray.count
        }
        else {
            return arrayMosque.count
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 125
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == tblSearchpop {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelMosqueCell", for: indexPath) as! SelMosqueCell
            
            cell.selectionStyle = .none
            let diccat = searchArray.object(at: indexPath.row) as! JSON
            
            print(diccat)
            cell.lblMosquename.text = diccat["username"].stringValue
            cell.lblMosquename.textColor = UIColor.black
            cell.lblmosqueaddress.text = diccat["street_address"].stringValue
            cell.lblmosqueaddress.textColor = UIColor.black
            let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
            print(avtar)
            cell.imgMosque.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelMosqueCell", for: indexPath) as! SelMosqueCell
            
            cell.selectionStyle = .none
            let diccat = arrayMosque.object(at: indexPath.row) as! JSON
            
            print(diccat)
            
            let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
            print(avtar)
            cell.imgMosque.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
            
            
            
            let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
            print(mosqueid)
            
          
            
            
            cell.lblMosquename.text = diccat["username"].stringValue
            cell.lblmosqueaddress.text = diccat["street_address"].stringValue
            return cell
        }
    }
    
    @objc func markButtonPressed(_ sender: UIButton)
    {
        print("Mark")
    }
    @objc func editButtonPressed(_ sender: UIButton)
    {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView == tblSearchpop {
            tblSearchpop.isHidden = true
            let diccat = searchArray.object(at: indexPath.row) as! JSON
            
            print(diccat)
            
            strmosqueid = diccat["_id"].stringValue as NSString
            UserDefaults.standard.set(strmosqueid, forKey: "mosque_id")
            
            let mosquename = diccat["username"].stringValue
            let mosqueaddress = diccat["street_address"].stringValue
            
            
          
            
            UserDefaults.standard.set(mosquename, forKey: "mosque_name")
            UserDefaults.standard.set(mosqueaddress, forKey: "mosque_address")
            
            let callVC:DonateVC  = ViewControllerHelper.getViewController(ofType: .donation) as! DonateVC
            callVC.mosqueid = strmosqueid as String
            self.navigationController?.pushViewController(callVC, animated: true)
            
          
        }
        else {
            let diccat = arrayMosque.object(at: indexPath.row) as! JSON
            
            print(diccat)
            strmosqueid = diccat["_id"].stringValue as NSString
            
            UserDefaults.standard.set(strmosqueid, forKey: "mosque_id")
            let mosquename = diccat["username"].stringValue
            let mosqueaddress = diccat["street_address"].stringValue
            
           
            
            
            UserDefaults.standard.set(mosquename, forKey: "mosque_name")
            UserDefaults.standard.set(mosqueaddress, forKey: "mosque_address")
            
            let callVC:DonateVC = ViewControllerHelper.getViewController(ofType: .donation) as! DonateVC
            callVC.mosqueid = strmosqueid as String
            self.navigationController?.pushViewController(callVC, animated: true)
           
            
          
        }
    }
    
   
    
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    @IBAction func selectLocationClicked(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchApi(){
        
        
        
        kApiClass .shared .callAPI(WithType: .searchmosque, WithParams: [
            "searchmosque":txtSearch.text!,
            
            
            
            
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
                        
                        let swiftyJsonVar = JSON(response!)
                        print(swiftyJsonVar)
                        
                        self.searchArray = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.searchArray);
                        if(self.searchArray.count == 0){
                            self.tblSearchpop.isHidden = true
                            return
                        }
                        self.tblSearchpop.reloadData()
                        self.tblSearchpop.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblSearchpop.isHidden = true
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .home)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func bookmarkClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .Bookmark)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func searchClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .Search)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func donationClicked(_ sender: Any) {
        // let callVC = ViewControllerHelper.getViewController(ofType: .mosquelistVC)
        // self.navigationController?.pushViewController(callVC, animated: false)
        
        let myViewController = MosquelistVC(nibName: "MosquelistVC", bundle: nil)
        self.navigationController?.pushViewController(myViewController, animated: true)
        
        
    }
    @IBAction func settingsClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .settings)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
        
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
