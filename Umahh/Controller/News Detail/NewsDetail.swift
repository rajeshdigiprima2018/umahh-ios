//
//  NewsDetail.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class NewsDetail: UIViewController {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDate: UILabel!
      @IBOutlet var imgdetail: UIImageView!
    @IBOutlet var txtdetail: UITextView!
    
    @IBOutlet var viewbg: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["News_Detail"]!))
        
        appDelegate.setRoundRectAndBorderColor(view: imgdetail, color: UIColor.clear, width: 1.0, radious: 5.0)
        
        self.NewsDetailApi()
    }
    
    func NewsDetailApi(){
        customLoader.show()
        let newsid:String = UserDefaults.standard.object(forKey: "News_id") as! String
        print(newsid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //  let urlPath =  "http://139.59.83.155:4002/api/mosque/Activities/getAll/5c88c59990361c17a8600e80"
        
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/News/get/\(newsid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.viewbg.isHidden = false
                
                let dicdata = swiftyJsonVar["data"] as JSON
                print(dicdata)
                
              self.lblTitle.text = dicdata["title"].stringValue
               // self.lblDate.text = swiftyJsonVar["startDate"].stringValue
                //  self.lblDate.text = swiftyJsonVar["startDate"].stringValue
                
                
                let startdateContent = dicdata["startDate"].stringValue
                
                let startdateArr = startdateContent.components(separatedBy: ".")
                
                let startdate    = startdateArr[0]
                
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let showDate = inputFormatter.date(from: startdate)
                print(showDate!)
                inputFormatter.dateFormat = "dd MMM"
                let startdateString = inputFormatter.string(from: showDate!)
                print(startdateString)
                
                
//                let enddateContent = dicdata["endDate"].stringValue
//
//                let enddateArr = enddateContent.components(separatedBy: ".")
//
//                let enddate    = enddateArr[0]
//
//                let inputFormatter1 = DateFormatter()
//                inputFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                let showDate1 = inputFormatter1.date(from: enddate)
//                print(showDate1!)
//                inputFormatter1.dateFormat = "dd MMM yyyy"
//                let enddateString = inputFormatter1.string(from: showDate1!)
//                print(enddateString)
                
                self.lblDate.text =  "\(startdateString)\(" to ")\("june 27 2019")"
                

                let content =  dicdata["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: content).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
         
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
   attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                
                self.txtdetail.attributedText = attributedString
               
                self.txtdetail.linkTextAttributes = [
                    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
                ]
                self.txtdetail.linkTextAttributes = [NSAttributedStringKey.underlineColor.rawValue: UIColor.clear]
               

                let img_url = dicdata["avtar"].stringValue

                let profile : String =  "http://167.172.131.53:4002\(img_url)"
                print(profile)
                self.imgdetail.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
                
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
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
