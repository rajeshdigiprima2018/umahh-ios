//
//  MyDonationVC.swift
//  Umahh
//
//  Created by mac on 28/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON

class MyDonationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var TableDonation: UITableView!
    var strmosqueid = NSString();
    var arrayDonation = NSArray();
    
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "My Donation")
        
        TableDonation.register(UINib(nibName: "MyDonationCell", bundle: nil), forCellReuseIdentifier: "MyDonationCell")
        
        self.mosquelistApi()
    }
    
    func mosquelistApi(){
        customLoader.show()
        
        let access_token:String = UserDefaults.standard.object(forKey: "access_token") as! String
                         print(access_token)
                  
                  let token = "\("Bearer")\(access_token)"
                  print(token)
             let headers: HTTPHeaders = [
                    "Accept": "application/json",
                   "Authorization":token]
            print(headers)
        
                
                let urlPath =  "http://167.172.131.53:4002/api/payment/getPaymentByUser"
                print(urlPath)
                
                
                Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        print(response)
                        let swiftyJsonVar = JSON(response.result.value!)
                        print(swiftyJsonVar)
                        self.arrayDonation = swiftyJsonVar["data"].arrayValue as NSArray
                        print(self.arrayDonation);
                        self.TableDonation.reloadData()
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
        
        return arrayDonation.count
        
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDonationCell", for: indexPath) as! MyDonationCell
        
        cell.selectionStyle = .none
        let diccat = arrayDonation.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
let startdateContent = diccat["updatedAt"].stringValue
      
      let startdateArr = startdateContent.components(separatedBy: ".")
      
      let startdate    = startdateArr[0]
      
      let inputFormatter = DateFormatter()
      inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      let showDate = inputFormatter.date(from: startdate)
      print(showDate!)
      inputFormatter.dateFormat = "yyyy-MM-dd"
      let startdateString = inputFormatter.string(from: showDate!)
      print(startdateString)
      
      cell.lblTime.text = startdateString
       cell.lblTransid.text = diccat["txn_id"].stringValue
  
        let mosquedata = diccat["mosque_id"]
        
        cell.lblPrice.text = "\("$ ")\(diccat["amount"].stringValue)"
                       
              
      cell.lblName.text = mosquedata["username"].stringValue
        return cell
        
    }
    
    @objc func markButtonPressed(_ sender: UIButton)
    {
        print("Mark")
    }
    @objc func editButtonPressed(_ sender: UIButton)
    {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       let callVC = ViewControllerHelper.getViewController(ofType: .home)
              self.navigationController?.pushViewController(callVC, animated: false)
        
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
    
}
    
