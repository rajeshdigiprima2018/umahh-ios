//
//  AllMosqueListVC.swift
//  Umahh
//
//  Created by mac on 26/08/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON

class AllMosqueListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var TableViewmosque: UITableView!
    var strmosqueid = NSString();
    var arrayMosque = NSArray();
    
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "Mosque Near you")
        
        TableViewmosque.register(UINib(nibName: "MosqueListCell", bundle: nil), forCellReuseIdentifier: "MosqueListCell")
        
        self.mosquelistApi()
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
        
        return arrayMosque.count
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 125
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MosqueListCell", for: indexPath) as! MosqueListCell
        
        cell.selectionStyle = .none
        let diccat = arrayMosque.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        
        
        
        
        let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
        print(avtar)
        cell.imgMosque.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
        
        
        cell.lblMosquename.text = diccat["username"].stringValue
        cell.lblmosqueaddress.text = diccat["street_address"].stringValue
        
        cell.lblmosquedistance.text = "\(diccat["distance"].stringValue) km"
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
        
        let diccat = arrayMosque.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        strmosqueid = diccat["_id"].stringValue as NSString
        
        UserDefaults.standard.set(strmosqueid, forKey: "sel_mosque_id")
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        
        callVC.mosqueid = strmosqueid as String
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.pushViewController(callVC, animated: true)
        
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
    
