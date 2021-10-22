//
//  AssociationList.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AssociationList: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblAssociate: UITableView!
    var arrayAssociate = NSArray();
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblAssociate.estimatedRowHeight = 188.0
        tblAssociate.rowHeight = UITableViewAutomaticDimension

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Associates"]!))
        
          tblAssociate.register(UINib(nibName: "AssociateCell", bundle: nil), forCellReuseIdentifier: "AssociateCell")
        self.associatelistApi()
        
    }
    
    func associatelistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/Associates/getAll/5c88c59990361c17a8600e80"
        
        
       let urlPath =  "http://167.172.131.53:4002/api/mosque/Associates/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayAssociate = swiftyJsonVar["data"]["associate_user"].arrayValue as NSArray
                
                print(self.arrayAssociate);
                self.tblAssociate.reloadData()
                
                
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
        return arrayAssociate.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssociateCell", for: indexPath) as! AssociateCell
        let diccat = arrayAssociate.object(at: indexPath.row) as! JSON

        print(diccat)
        cell.lblname.text = diccat["username"].stringValue
        cell.lbltext.text = diccat["street_address"].stringValue
      //  cell.lblDescription.text = diccat["description_service"].stringValue
        
        let content = diccat["description_service"].string
        
        // let content = "<p>&nbsp;&nbsp;test result</p><br/>"; // My String
        
        let str = content?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let a = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.lblDescription.text = a
        
        let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
        print(avtar)
        cell.imgAssociate.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_default"))
        
     
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diccat = arrayAssociate.object(at: indexPath.row) as! JSON
      //  UserDefaults.standard.set(diccat["_id"].stringValue, forKey: "sel_mosque_id")
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = diccat["_id"].stringValue
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 188
//        }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
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
