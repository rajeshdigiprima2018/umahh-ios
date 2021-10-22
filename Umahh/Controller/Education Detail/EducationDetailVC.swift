//
//  EducationDetailVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EducationDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblDetail: UITableView!
     var arrayEducation = NSArray();
      var strTitle = NSString();
     var strdate = NSString();
     var strtime = NSString();
     var straddress = NSString();
     var strphone = NSString();
     var strCourse = NSString();
    var strMethodology = NSString();
    var strDuration = NSString();
     var strFee = NSString();
     var strPrerequist = NSString();
    var strAbout = NSString();

    override func viewDidLoad() {
        super.viewDidLoad()
        tblDetail.estimatedRowHeight = 73.0
        tblDetail.rowHeight = UITableViewAutomaticDimension

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Education_Detail"]!))
        
        
        tblDetail.register(UINib(nibName: "EducationInfoCell", bundle: nil), forCellReuseIdentifier: "EducationInfoCell")
        
         tblDetail.register(UINib(nibName: "EducationContentCell", bundle: nil), forCellReuseIdentifier: "EducationContentCell")
        self.edcationdetailApi()
    }
    
    func edcationdetailApi(){
        customLoader.show()
        let eduid:String = UserDefaults.standard.object(forKey: "edu_id") as! String
        print(eduid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        // let urlPath =  "http://139.59.83.155:4002/api/mosque/education/getAll/5c88c59990361c17a8600e80"
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/education/get/\(eduid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                let dicdata = swiftyJsonVar["data"] as JSON
                print(dicdata)
                
                self.strTitle = dicdata["title"].stringValue as NSString
                
                self.strphone = dicdata["mobile"].stringValue as NSString
                self.straddress = dicdata["address"].stringValue as NSString
                 self.strCourse = dicdata["course_objective"].stringValue as NSString
                self.strMethodology = dicdata["methodology"].stringValue as NSString
                 self.strDuration = dicdata["duration"].stringValue as NSString
                 self.strFee = dicdata["registration_fee"].stringValue as NSString
                self.strPrerequist = dicdata["pre_requisites"].stringValue as NSString
                self.strAbout = dicdata["about_instructor"].stringValue as NSString
                
               let getstartdate = dicdata["startDate"].stringValue as NSString
                 let getenddate = dicdata["endDate"].stringValue as NSString
                
                
                let startdateArr = getstartdate.components(separatedBy: ".")
                
                let startdate    = startdateArr[0]
                
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let showDate = inputFormatter.date(from: startdate)
                print(showDate!)
                inputFormatter.dateFormat = "dd MMM"
                let startdateString = inputFormatter.string(from: showDate!)
                print(startdateString)
                
                
                
                
                let enddateArr = getenddate.components(separatedBy: ".")
                
                let enddate    = enddateArr[0]
                
                let inputFormatter1 = DateFormatter()
                inputFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let showDate1 = inputFormatter1.date(from: enddate)
                print(showDate1!)
                inputFormatter1.dateFormat = "dd MMM yyyy"
                let enddateString = inputFormatter1.string(from: showDate1!)
                print(enddateString)
                
                self.strdate =  "\(startdateString)\(" to ")\(enddateString)" as NSString
                
                
                
                let getstarttime = dicdata["startTime"].stringValue as NSString
                let getstrendtime = dicdata["endTime"].stringValue as NSString
                
                
               
                
                let starttimeArr = getstarttime.components(separatedBy: " ")
                print(starttimeArr)
                
                let starttime    = starttimeArr[4]
                
                let inputFormatter2 = DateFormatter()
                inputFormatter2.dateFormat = "HH:mm:ss"
                let showtime = inputFormatter2.date(from: starttime)
                print(showtime!)
                inputFormatter2.dateFormat = "hh:mm a"
                let starttimeString = inputFormatter2.string(from: showtime!)
                print(starttimeString)
                
               
                
                let endtimeArr = getstrendtime.components(separatedBy: " ")
                print(endtimeArr)
                
                let endtime    = endtimeArr[4]
                
                let inputFormatter3 = DateFormatter()
                inputFormatter3.dateFormat = "HH:mm:ss"
                let showtime2 = inputFormatter3.date(from: endtime)
                print(showtime2!)
                inputFormatter3.dateFormat = "hh:mm a"
                let endtimeString = inputFormatter3.string(from: showtime2!)
                print(endtimeString)
                
                self.strtime =  "\(starttimeString)\(" - ")\(enddateString)" as NSString
                
                
                self.tblDetail.reloadData()
                self.tblDetail.isHidden = false
                
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
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationInfoCell", for: indexPath) as! EducationInfoCell
       
        
            cell.lblTitle.text = strTitle as String
            cell.lblAddress.text = straddress as String
            cell.lblphone.text = strphone as String
            
            cell.lbldate.text = strdate as String
            cell.lbltime.text = strtime as String
            
            
          
            
           
        
        
        
        cell.selectionStyle = .none
            return cell
        }
        else {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "EducationContentCell", for: indexPath) as! EducationContentCell
           
             if indexPath.row == 1 {
                
                 cell.lblTitle.text = "Course Objcective"
                
               
                
                
                
                let htmlData = NSString(string: strCourse).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
                cell.lblContent.attributedText = attributedString
                
            }
           else if indexPath.row == 2 {
                cell.lblTitle.text = "Methodology"
                
                //let content =  diccat["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: strMethodology).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
               
                
                cell.lblContent.attributedText = attributedString
            }
            
            else if indexPath.row == 3 {
                cell.lblTitle.text = "Duration"
                
               // let content =  diccat["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: strDuration).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
               
                
                cell.lblContent.attributedText = attributedString
            }
            else if indexPath.row == 4 {
                cell.lblTitle.text = "Registration Fee"
                
               // let content =  diccat["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: strFee).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
                //cell.lbltext.attributedText = attributedString
                
                cell.lblContent.attributedText = attributedString
            }
            else if indexPath.row == 5 {
                cell.lblTitle.text = "Pre requisties"
                
              //  let content =  diccat["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: strPrerequist).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
               // cell.lbltext.attributedText = attributedString
                
                cell.lblContent.attributedText = attributedString
            }
            else if indexPath.row == 6 {
                cell.lblTitle.text = "About the Instructor"
                
                //let content =  diccat["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: strAbout).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                
                
                cell.lblContent.attributedText = attributedString
                
               
            }
            
            
        cell.selectionStyle = .none
                return cell
        }
    }
    
   
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
