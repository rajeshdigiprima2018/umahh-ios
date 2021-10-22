//
//  PersonnageVC.swift
//  Umahh
//
//  Created by mac on 16/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PersonnageVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblPersonnage: UITableView!
    var arrayPersonnage = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPersonnage.estimatedRowHeight = 65.0
        tblPersonnage.rowHeight = UITableViewAutomaticDimension
        
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
        tblPersonnage.register(UINib(nibName: "PersonnageCell", bundle: nil), forCellReuseIdentifier: "PersonnageCell")
        self.personnageListApi()
        
    }
    
    func personnageListApi(){
        
        customLoader.show()
        
        
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/getpersonnageUsers/5da5a95d1e202e2b2a794aa5"
        
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
                
                
                self.arrayPersonnage = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayPersonnage);
                
                if self.arrayPersonnage.count>0{
                    self.tblPersonnage.isHidden = false
                    self.tblPersonnage.reloadData()
                }
                else {
                    self.tblPersonnage.isHidden = true
                }
                
                
                
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
        return arrayPersonnage.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonnageCell", for: indexPath) as! PersonnageCell
        
        
        let diccat = arrayPersonnage.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        
        cell.lbltitle.text = diccat["title"].stringValue
        
        
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.navigationController!.pushViewController(PersonnageDetailVC(nibName: "PersonnageDetailVC", bundle: nil), animated: true)
    }
    
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
