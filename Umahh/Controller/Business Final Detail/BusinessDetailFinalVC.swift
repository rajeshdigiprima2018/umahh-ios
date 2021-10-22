//
//  BusinessDetailFinalVC.swift
//  Umahh
//
//  Created by mac on 29/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BusinessDetailFinalVC: UIViewController {
    @IBOutlet var imgTitle: UIImageView!
     @IBOutlet var lblTitle: UILabel!
     @IBOutlet var btnAddress: UIButton!
     @IBOutlet var btnNumber: UIButton!
     @IBOutlet var txtDescription: UITextView!

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
        
        
        
        let title:String = UserDefaults.standard.object(forKey: "business_title") as! String
        print(title)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: title)
        
       
        self.businessorganizationApi()
        
      
    }
    
    func businessorganizationApi(){
       
        customLoader.show()
        let businessid:String = UserDefaults.standard.object(forKey: "businessdetailid") as! String
        print(businessid)
        
        
        
        
        
        let urlPath =  "http://167.172.131.53:4002/api/user/getUserDetail/\(businessid)"
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                let dicdata = swiftyJsonVar["data"] as JSON
                print(dicdata)
                
                self.lblTitle.text = dicdata["username"].stringValue
                self.btnNumber.setTitle(dicdata["mobile"].stringValue, for: .normal)
                 self.btnAddress.setTitle(dicdata["street_address"].stringValue, for: .normal)
               
                
                let content =  dicdata["description_service"].stringValue
                
                
                
                let htmlData = NSString(string: content).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                
                self.txtDescription.attributedText = attributedString
                
                self.txtDescription.linkTextAttributes = [
                    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
                ]
                self.txtDescription.linkTextAttributes = [NSAttributedStringKey.underlineColor.rawValue: UIColor.clear]
                
                let img_url = dicdata["avtar"].stringValue
                
                let profile : String =  "http://167.172.131.53:4002\(img_url)"
                print(profile)
                self.imgTitle.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
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
