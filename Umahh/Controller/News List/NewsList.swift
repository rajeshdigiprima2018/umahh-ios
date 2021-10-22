//
//  NewsList.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsList: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblNews: UITableView!
     var arrayNews = NSArray();
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblNews.estimatedRowHeight = 100.0
        tblNews.rowHeight = UITableViewAutomaticDimension
        
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["News"]!))
        
        
        tblNews.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.newslistApi()
    }
    
    func newslistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
      

        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/News/getAll/\(mosqueid)"

        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayNews = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayNews);
                self.tblNews.reloadData()
                
                
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
        return arrayNews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let diccat = arrayNews.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lbltext.text = diccat["title"].stringValue
        // cell.lblname.text = diccat["byName"].stringValue
        
        let imageurl = diccat["avtar"].stringValue
        print(imageurl)
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
               print(dict)
        cell.btnViewmore.setTitle((dict["View_More"]!), for: .normal)
        
        cell.btnViewmore.tag = indexPath.row
        cell.btnViewmore.addTarget(self, action: #selector(self.btnviewmoreAction(_:)), for: .touchUpInside)
        
        
        
        
        
        
        let profile : String =  "http://167.172.131.53:4002\(imageurl)"
        print(profile)
        cell.imgNews.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
        
         cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func btnviewmoreAction(_ sender: UIButton) {
        let diccat = arrayNews.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        UserDefaults.standard.set(diccat["id"].stringValue, forKey: "News_id")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .newsDetail)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayNews.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        UserDefaults.standard.set(diccat["id"].stringValue, forKey: "News_id")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .newsDetail)
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
