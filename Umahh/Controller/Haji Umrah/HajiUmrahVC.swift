//
//  HajiUmrahVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HajiUmrahVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblHajiumrah: UITableView!
    var arrayHajiumrah = NSArray();
    
  
    
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
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                            print(dict)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["haji_umrah"]!))
        
 
        tblHajiumrah.register(UINib(nibName: "HajiumrahCell", bundle: nil), forCellReuseIdentifier: "HajiumrahCell")
        self.hajiumrahlistApi()
    }
    
    func hajiumrahlistApi(){
        customLoader.show()
       
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/News/getAll/5c88c59990361c17a8600e80"
        
        
        let urlPath =  "http://167.172.131.53:4002/api/hajjumrah/getAllCategoryUmrah"

        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayHajiumrah = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayHajiumrah);
                self.tblHajiumrah.reloadData()
                
                
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
        return arrayHajiumrah.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HajiumrahCell", for: indexPath) as! HajiumrahCell
        let diccat = arrayHajiumrah.object(at: indexPath.row) as! JSON
        
        print(diccat)
      
        cell.lblname.text = diccat["name"].stringValue
        
        let profile : String =  "http://167.172.131.53:4002\(diccat["imageUrl"].stringValue)"
        print(profile)
         cell.imgFeed.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
        
        // cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        cell.selectionStyle = .none
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayHajiumrah.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let profile : String =  "http://167.172.131.53:4002\(diccat["imageUrl"].stringValue)"
        print(profile)
       
            let callVC = ViewControllerHelper.getViewController(ofType: .Hajiumrahdetail)
        //callVC.strid = diccat["name"].stringValue
         UserDefaults.standard.set(diccat["hajjumrahCategory_id"].stringValue, forKey: "hajjumrahCategory_id")
         UserDefaults.standard.set(profile, forKey: "img_url")
         UserDefaults.standard.set(diccat["name"].stringValue, forKey: "haziumrahtitle")
            self.navigationController?.pushViewController(callVC, animated: true)
        }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
