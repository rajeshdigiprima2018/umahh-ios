//
//  TermsVC.swift
//  Umahh
//
//  Created by mac on 27/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TermsVC: UIViewController {
    
     @IBOutlet weak var txtTerms: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTerms()
    }

    func getTerms(){
    customLoader.show()
     let urlPath =  "http://167.172.131.53:4002/api/termcondition/getAll"
          
          print(urlPath)
        
        let access_token:String = UserDefaults.standard.object(forKey: "access_token") as! String
                          print(access_token)
        
        let token = "\("Bearer")\(access_token)"
                   print(token)
        
        let headers: HTTPHeaders = [
          "Accept": "application/json",
           "Authorization": token]
                   print(headers)
          
          
          Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {
              response in
              switch (response.result) {
              case .success:
                  print(response)
                  let swiftyJsonVar = JSON(response.result.value!)
                  print(swiftyJsonVar)
                  let arrayContent = swiftyJsonVar["data"].arrayValue as NSArray
                   print(arrayContent);
                  
                  let message = swiftyJsonVar["message"].stringValue
                  print(message)
                  if message != "Invalid token" {
                    if arrayContent.count > 0{
                  let diccat = arrayContent.object(at: 0) as! JSON

                    print(diccat)
                  
                   let content = diccat["description"].stringValue
                  print(content)
                 
                         
                  let str = content.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                         
                  let a = str.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

                       
                  
                  self.txtTerms.text = a
                    }
                  }
                  
                  customLoader.hide()
                  
                  break
              case .failure:
                  customLoader.hide()
                  print(Error.self)
              }
          }
      }

}
