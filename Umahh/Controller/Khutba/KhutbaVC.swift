//
//  KhutbaVC.swift
//  Umahh
//
//  Created by mac on 13/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class KhutbaVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblKhutba: UITableView!
    var arrayKhutba = NSArray();
    var mosqueid:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblKhutba.estimatedRowHeight = 113.0
        tblKhutba.rowHeight = UITableViewAutomaticDimension
        
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Khutba"]!))
        
        
        tblKhutba.register(UINib(nibName: "EducationListCell", bundle: nil), forCellReuseIdentifier: "EducationListCell")
        self.khutbalistApi()
    }
    
    func khutbalistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        // let urlPath =  "http://139.59.83.155:4002/api/mosque/education/getAll/5c88c59990361c17a8600e80"
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/khutba/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.arrayKhutba = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayKhutba);
                self.tblKhutba.reloadData()
                
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
        return arrayKhutba.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationListCell", for: indexPath) as! EducationListCell
        let diccat = arrayKhutba.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        cell.lbledudate.text = diccat["speaker_name"].string
        
        // cell.imagedate.isHidden = true
        //cell.imagedate.removeFromSuperview()
        let content = diccat["title"].string
        
       
        
        let str = content?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let a = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.lbleduname.text = a
        
        
        
        
        let startdateContent = diccat["startDate"].stringValue
        
        let startdateArr = startdateContent.components(separatedBy: ".")
        
        let startdate    = startdateArr[0]
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let showDate = inputFormatter.date(from: startdate)
        print(showDate!)
        inputFormatter.dateFormat = "dd MMM"
        let startdateString = inputFormatter.string(from: showDate!)
        print(startdateString)
        
        
      
        
        
        let starttimeContent = diccat["startTime"].stringValue
        
        let starttimeArr = starttimeContent.components(separatedBy: " ")
        print(starttimeArr)
        
        let starttime    = starttimeArr[4]
        
        let inputFormatter2 = DateFormatter()
        inputFormatter2.dateFormat = "HH:mm:ss"
        let showtime = inputFormatter2.date(from: starttime)
        print(showtime!)
        inputFormatter2.dateFormat = "hh:mm a"
        let starttimeString = inputFormatter2.string(from: showtime!)
        print(starttimeString)
        
       
        
        
        cell.lbledutime.text =  "\(starttimeString)"
        
        
        cell.btnmore.isHidden = true
       
        
        
        
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
   
    
}
