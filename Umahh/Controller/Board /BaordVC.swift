//
//  BaordVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BaordVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tblBoard: UITableView!
     var arrayBoard = NSArray();
    var mosqueid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblBoard.estimatedRowHeight = 100.0
        tblBoard.rowHeight = UITableViewAutomaticDimension

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Board"]!))
        
        
        tblBoard.register(UINib(nibName: "BoardCell", bundle: nil), forCellReuseIdentifier: "BoardCell")
        self.baordlistApi()
    }
    
    func baordlistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
    
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/Board/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.arrayBoard = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayBoard);
                self.tblBoard.reloadData()
                
                
                
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
        return arrayBoard.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardCell
        let diccat = arrayBoard.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lblMosquename.text = diccat["name"].stringValue
        cell.lblmosqueposition.text = diccat["title"].stringValue
       // cell.lblmosquedescription.text = diccat["textarea"].stringValue
        //let content = diccat["textarea"].stringValue as NSString
        
        let content = diccat["textarea"].string
        
       // let content = "<p>&nbsp;&nbsp;test result</p><br/>"; // My String
        
        let str = content?.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let a = str?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

        cell.lblmosquedescription.text = a
        
        let imagdata = diccat["pictures"].arrayValue
        print(imagdata)
        
        let url = imagdata[0]
        
        
        
        
        
        
        let profile : String =  "http://167.172.131.53:4002\(url["url"])"
        print(profile)
        cell.imgBoard.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "user_default"))
        
        cell.selectionStyle = .none
        return cell
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
