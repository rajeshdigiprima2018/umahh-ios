//
//  EducationListVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EducationListVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblEducation: UITableView!
     var arrayEducation = NSArray();
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblEducation.estimatedRowHeight = 113.0
        tblEducation.rowHeight = UITableViewAutomaticDimension
        
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
               
               //btnNext.setTitle((dict["next"]!), for: .normal)
               
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Education"]!))
        
        
        tblEducation.register(UINib(nibName: "EducationListCell", bundle: nil), forCellReuseIdentifier: "EducationListCell")
        self.edcationlistApi()
    }
    
    func edcationlistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
       // let urlPath =  "http://139.59.83.155:4002/api/mosque/education/getAll/5c88c59990361c17a8600e80"
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/education/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.arrayEducation = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayEducation);
                self.tblEducation.reloadData()
                
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
        return arrayEducation.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationListCell", for: indexPath) as! EducationListCell
        let diccat = arrayEducation.object(at: indexPath.row) as! JSON
        
        print(diccat)
       
        
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
        
        
        let enddateContent = diccat["endDate"].stringValue
        
        let enddateArr = enddateContent.components(separatedBy: ".")
        
        let enddate    = enddateArr[0]
       
        let inputFormatter1 = DateFormatter()
        inputFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let showDate1 = inputFormatter1.date(from: enddate)
        print(showDate1!)
        inputFormatter1.dateFormat = "dd MMM yyyy"
        let enddateString = inputFormatter1.string(from: showDate1!)
        print(enddateString)
        
        cell.lbledudate.text =  "\(startdateString)\(" to ")\(enddateString)"
        
        
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
        
        let endtimeContent = diccat["endTime"].stringValue
        
        let endtimeArr = endtimeContent.components(separatedBy: " ")
        print(endtimeArr)
        
        let endtime    = endtimeArr[4]
        
        let inputFormatter3 = DateFormatter()
        inputFormatter3.dateFormat = "HH:mm:ss"
        let showtime2 = inputFormatter3.date(from: endtime)
        print(showtime2!)
        inputFormatter3.dateFormat = "hh:mm a"
        let endtimeString = inputFormatter3.string(from: showtime2!)
        print(endtimeString)
        
         cell.lbledutime.text =  "\(starttimeString)\(" - ")\(enddateString)"
        
       
        cell.btnmore.tag = indexPath.row
        cell.btnmore.addTarget(self, action: #selector(self.btnviewmoreAction(_:)), for: .touchUpInside)
        
      let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                           print(dict)
                    
    cell.btnmore.setTitle((dict["View_More"]!), for: .normal)
       
        
        
        cell.selectionStyle = .none
       
        return cell
    }
    
    @objc func btnviewmoreAction(_ sender: UIButton) {
        let diccat = arrayEducation.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        UserDefaults.standard.set(diccat["id"].stringValue, forKey: "edu_id")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .EduDetail)
        self.navigationController?.pushViewController(callVC, animated: true)
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayEducation.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        UserDefaults.standard.set(diccat["id"].stringValue, forKey: "edu_id")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .EduDetail)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
