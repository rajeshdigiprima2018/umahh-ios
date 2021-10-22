//
//  QuranListVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuranListVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
     @IBOutlet weak var tblQuran: UITableView!
     @IBOutlet weak var viewSura: UIView!
      @IBOutlet weak var viewJuz: UIView!
     @IBOutlet weak var viewQuran: UIView!
    
    @IBOutlet weak var btnSura: UIButton!
         @IBOutlet weak var btnJuz: UIButton!
    
     var arraySura = NSArray();
     var arrayJuz = NSArray();
     var arrayQuran = NSArray();
    
      var strType = NSString();

    override func viewDidLoad() {
        super.viewDidLoad()
 strType = "Sura"
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
        
       // btnSura.setTitle((dict["Surah"]!), for: .normal)
        //btnJuz.setTitle((dict["Quran"]!), for: .normal)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Quran"]!))
        
        
        
        tblQuran.register(UINib(nibName: "QuranCell", bundle: nil), forCellReuseIdentifier: "QuranCell")
        
        if  strType == "Sura" {
            self.SuraListApi()
        }
        else {
        self.juzListApi()
        }
    }
    
     @IBAction func SuraClicked(_ sender: Any) {
        viewSura.isHidden = false
         viewJuz.isHidden = true
       
        self.SuraListApi()
    }
    
    func SuraListApi(){
        strType = "Sura"
        customLoader.show()
       
        
        
       
        
        
        let urlPath =  "http://api.alquran.cloud/v1/surah"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arraySura = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arraySura);
                
                if self.arraySura.count>0{
                     self.tblQuran.isHidden = false
                    self.tblQuran.reloadData()
                }
                else {
                     self.tblQuran.isHidden = true
                }
               
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func juzClicked(_ sender: Any) {
        viewSura.isHidden = true
        viewJuz.isHidden = false
        
        self.juzListApi()
    }
    
    func juzListApi(){
        strType = "Juz"
        customLoader.show()
       
        
        
        
        
        
//        let urlPath =  "http://api.alquran.cloud/v1/juz/30/en.asad"
//
//        print(urlPath)
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/getjuz"
        
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
                
                
                self.arrayJuz = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayJuz);
                
                if self.arrayJuz.count>0{
                     self.tblQuran.isHidden = false
                    self.tblQuran.reloadData()
                }
                else {
                    self.tblQuran.isHidden = true
                }
                
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    @IBAction func quranClicked(_ sender: Any) {
        viewSura.isHidden = true
        viewJuz.isHidden = true
        viewQuran.isHidden = false
        self.juzListApi()
    }
    
    func quranListApi(){
        strType = "Quran"
        customLoader.show()
        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
     
        
        let urlPath =  "http://api.alquran.cloud/v1/quran/hn.asad"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayQuran = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayQuran);
                
                if self.arrayQuran.count>0{
                    self.tblQuran.isHidden = false
                    self.tblQuran.reloadData()
                }
                else {
                    self.tblQuran.isHidden = true
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
          if strType == "Sura" {
            
        return arraySura.count
        }
          else {
              return arrayJuz.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuranCell", for: indexPath) as! QuranCell
        
        if strType == "Sura" {
        
        let diccat = arraySura.object(at: indexPath.row) as! JSON
        
        print(diccat)
         print(diccat["englishName"].stringValue)
        print(diccat["number"].stringValue)
        print(diccat["name"].stringValue)
        
        cell.lblname.text = diccat["englishName"].stringValue
            
            let indexValue :String = String(format: "%d", indexPath.row+1)
            print(indexValue)
            
         cell.lblCount.text = indexValue
            
            
         cell.lblarabicname.text = diccat["name"].stringValue
            cell.lblarabicname.isHidden = false
        
        let description =  diccat["englishNameTranslation"].stringValue
        print(description)
        
        let noAyash =  diccat["numberOfAyahs"].stringValue
        print(noAyash)
        
        //cell.lbldescription.text =  "By \(diccat["byName"].stringValue)"
        cell.lbldescription.text =  "\(description) (\(noAyash))"
            
            //  cell.lbldescription.isHidden = false
       
        
       
        cell.selectionStyle = .none
        }
        else {
            let diccat = arrayJuz.object(at: indexPath.row) as! JSON
            
            print(diccat)

            
            cell.lbldescription.text = diccat["name"].stringValue
            cell.lblarabicname.text = diccat["aerobic_name"].stringValue

            
            let indexValue :String = String(format: "%d", indexPath.row+1)
            print(indexValue)
            
            cell.lblCount.text = indexValue
            cell.lblname.text =  "\("Juz") \(indexPath.row+1)"
     
            
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
          if strType == "Sura" {
        let diccat = arraySura.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        UserDefaults.standard.set(diccat["number"].stringValue, forKey: "number_id")
            
            UserDefaults.standard.set(diccat["englishName"].stringValue, forKey: "quran_name")
         
        
        let callVC = ViewControllerHelper.getViewController(ofType: .Qurandetail)
        self.navigationController?.pushViewController(callVC, animated: true)
        }
          else {
            let diccat = arrayJuz.object(at: indexPath.row) as! JSON
            
            print(diccat)
            
            let indexValue :String = String(format: "%d", indexPath.row+1)
            print(indexValue)

            
            UserDefaults.standard.set(indexValue, forKey: "number_id")
            
            UserDefaults.standard.set(diccat["name"].stringValue, forKey: "Juz_name")
         self.navigationController!.pushViewController(JuzDetailVC(nibName: "JuzDetailVC", bundle: nil), animated: true)
        }
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
