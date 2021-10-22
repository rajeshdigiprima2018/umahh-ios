//
//  SelectMosqueVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON


class SelectMosqueVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet weak var TableViewmosque: UITableView!
    let locationManager = CLLocationManager()
     @IBOutlet var txtSearch: UITextField!
      var searchArray = NSArray();
     var strmosqueid = NSString();
    @IBOutlet var tblSearchpop: UITableView!
     @IBOutlet var viewselectmosque: UIView!
   @IBOutlet weak var heightconstraint: NSLayoutConstraint!
     @IBOutlet var viewselectbg: UIView!
    
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblmosqueaddress: UILabel!
      @IBOutlet weak var imgSelectmos: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    
     var arrayMosque = NSArray();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                            print(dict)
                     
                      txtSearch.placeholder = dict["Type_mosque_name"]!
                      lblTitle.text = dict["Current_Mosque"]!
//         lblSubTitle.text = dict["Done"]!
                 
                      btnDone.setTitle(dict["submit"]!, for: .normal)
        
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        
        if mosqueid == ""{
            heightconstraint.constant = 0
            viewselectmosque.layoutIfNeeded()
            viewselectbg.isHidden =  true
        }
        
         txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if txtSearch.text == "" {
         tblSearchpop.isHidden = true
            return
        }
        self.searchApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserDefaults.standard.object(forKey: "profileload") != nil)
        {
          self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
       
    }
    
    func setViews()
    {
       appDelegate.setRoundRectAndBorderColor(view: imgSelectmos, color: UIColor.clear, width: 0.0, radious: imgSelectmos.frame.size.height/2)
        
        TableViewmosque.register(UINib(nibName: "SelMosqueCell", bundle: nil), forCellReuseIdentifier: "SelMosqueCell")
         tblSearchpop.register(UINib(nibName: "SelMosqueCell", bundle: nil), forCellReuseIdentifier: "SelMosqueCell")
        self.mosquelistApi()
    }
    
    func mosquelistApi(){
        customLoader.show()
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
        
        let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
    let urlPath =  "http://167.172.131.53:4002/api/mosque/nearby/\(latitude)/\(longitude)/\("99999")"
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/nearby/\("22.6941829330965")/\("75.9295288670566")/\("100")"
        
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
            
            if mosqueid == ""{
               heightconstraint.constant = 0
                viewselectmosque.layoutIfNeeded()
                viewselectbg.isHidden =  true
            }
            else {
             strmosqueid = diccat["_id"].stringValue as NSString
            if mosqueid == strmosqueid as String {
                print(mosqueid)
                
                UserDefaults.standard.set(mosqueid, forKey: "mosque_id")
                UserDefaults.standard.set(diccat["username"].stringValue, forKey: "mosque_name")
                UserDefaults.standard.set(diccat["street_address"].stringValue, forKey: "mosque_address")
               lblMosquename.text = diccat["username"].stringValue
                lblmosqueaddress.text = diccat["street_address"].stringValue
                let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
                print(avtar)
                imgSelectmos.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
                
                
            }
            }
            
            
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
            
            
            lblMosquename.text = diccat["username"].stringValue
            lblmosqueaddress.text = diccat["street_address"].stringValue
            
            UserDefaults.standard.set(mosquename, forKey: "mosque_name")
            UserDefaults.standard.set(mosqueaddress, forKey: "mosque_address")
            
            let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
            print(avtar)
            imgSelectmos.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
            
            heightconstraint.constant = 80
            viewselectmosque.layoutIfNeeded()
            viewselectbg.isHidden =  false
             self.selectmosqueApi()
 }
        else {
            let diccat = arrayMosque.object(at: indexPath.row) as! JSON
            
            print(diccat)
            strmosqueid = diccat["_id"].stringValue as NSString
            
            UserDefaults.standard.set(strmosqueid, forKey: "mosque_id")
            let mosquename = diccat["username"].stringValue
            let mosqueaddress = diccat["street_address"].stringValue
            
            lblMosquename.text = diccat["username"].stringValue
            lblmosqueaddress.text = diccat["street_address"].stringValue
            
            let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
            print(avtar)
            imgSelectmos.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
            
           
            UserDefaults.standard.set(mosquename, forKey: "mosque_name")
             UserDefaults.standard.set(mosqueaddress, forKey: "mosque_address")
            
            heightconstraint.constant = 80
            viewselectmosque.layoutIfNeeded()
            viewselectbg.isHidden =  false
            
            self.selectmosqueApi()
        }
    }
    
    func selectmosqueApi(){
          customLoader.show()
         let userid:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(userid)
        
        
        kApiClass .shared .callAPI(WithType: .selectmosque, WithParams: [
            "user_id": userid,
            "isSelect": "true",
            "mosque_id": strmosqueid
            
            
            
            
            ], Success: { (response, isSuccess, error) in
                
                
                
                if isSuccess == true
                {
                    print("yes");
                    
                    print(response as AnyObject)
                    
                    
                    
                    
                    
                    let x  = response?.value(forKey: "success")  as! Int
                    print(x)
                    
                    let getStatus = String(describing: x)
                    print(getStatus)
                    
                    
                    
                    
                    
                    
                    
                    if getStatus == "1" {
                        
                        let swiftyJsonVar = JSON(response!)
                        print(swiftyJsonVar)
                        
//                        self.searchArray = swiftyJsonVar["data"].arrayValue as NSArray
//                        print(self.searchArray);
//                        if(self.searchArray.count == 0){
//                             self.tblSearchpop.isHidden = true
//                            return
//                        }
//                        self.tblSearchpop.reloadData()
//                        self.tblSearchpop.isHidden = false
                        
                        
                        
                        
                        
                        
                    }
                    else {
                        self.tblSearchpop.isHidden = true
                    }
                }
                
        }, Failure:{_,_,_ in
            
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        
        let mosqueid:String = UserDefaults.standard.object(forKey: "mosque_id") as! String
        print(mosqueid)
        
        if mosqueid == "" {
             CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please select mosque", dismissDelay: 3)
            return
        }
        let callVC = ViewControllerHelper.getViewController(ofType: .home)
        self.navigationController?.pushViewController(callVC, animated: true)
        
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
