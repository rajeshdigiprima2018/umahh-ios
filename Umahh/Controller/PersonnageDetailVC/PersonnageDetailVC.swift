//
//  PersonnageDetailVC.swift
//  Umahh
//
//  Created by mac on 16/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PersonnageDetailVC: UIViewController {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var viewMain: UIView!
     @IBOutlet weak var txtContent: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)
        
        
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
               appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Personage"]!))
       
        self.personnageDetailApi()
        
    }
    
    func personnageDetailApi(){
        
        customLoader.show()
        
        
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/getpersonnageUserByPersonnageUserId/5da5a95d1e202e2b2a794aa1/5da5aa4a1e202e2b2a794b2a"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                //                let alldata = swiftyJsonVar["data"]
                //                print(alldata)
                
                
                let datapassonage = swiftyJsonVar["data"] as JSON
                print(datapassonage);
                
                self.lbltitle.text = datapassonage["title"].stringValue
                
                self.viewMain.isHidden = false
                
                let content =  datapassonage["textarea"].stringValue
                
                
                
                let htmlData = NSString(string: content).data(using: String.Encoding.unicode.rawValue)
                
                let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                
                
                
                
                let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                
                print(attributedString)
                
                
                
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
                
                self.txtContent.attributedText = attributedString
                
                self.txtContent.linkTextAttributes = [
                    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
                ]
                self.txtContent.linkTextAttributes = [NSAttributedStringKey.underlineColor.rawValue: UIColor.clear]
                
                
                
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
