//
//  NotificationVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationVC: UIViewController ,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblNoti: UITableView!
    var arrayNoti = NSArray();
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "Notification")
        
        
        tblNoti.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.notilistApi()
    }
    
    func notilistApi(){
        customLoader.show()
        let user_id:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(user_id)
        
         let urlPath =  "http://167.172.131.53:4002/api/notification/getAll/\(user_id)"
        
        
//        let urlPath =  "http://167.172.131.53:4002/api/mosque/News/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayNoti = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayNoti);
                self.tblNoti.reloadData()
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func DeletenotilistApi(id: String){
        customLoader.show()
        let user_id:String = UserDefaults.standard.object(forKey: "user_id") as! String
        print(user_id)
        
         let urlPath =  "http://167.172.131.53:4002/api/notification/send/\(id)"
        
        
     print(urlPath)
        Alamofire.request(urlPath, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
               
                self.notilistApi()
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
        return arrayNoti.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let diccat = arrayNoti.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let send_id = diccat["send_id"].dictionary
        print(send_id!)
        
         print(send_id!["username"]!)
        
        let name = send_id!["username"]!
        print(name)
        print(name.string!)
        
        
        
        cell.lblTitle.text = name.string!
        
         cell.lblname.text = send_id!["role"]?.stringValue
        
        let content = diccat["description"].string
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)

        
        let str = content?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let a = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.lblMessage.text = a
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func buttonClicked(sender : UIButton) {
        let diccat = arrayNoti.object(at: sender.tag) as! JSON
        
        self.DeletenotilistApi(id: diccat["notification_id"].string ?? "")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayNoti.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
       
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
