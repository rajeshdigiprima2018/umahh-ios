//
//  SupplicationVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SupplicationVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionintro: UICollectionView!
    
    var arraySupplicationimg = [String]()
    var arraySupplicationtitle = [String]()
     var arraysupplication = NSArray();
    
     var dict = NSDictionary()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
               print(dict)
        
        arraySupplicationimg = ["Morning _ Evening","Travel","Home _ Family","Joy _ Distress","Prayer","Praising Allah","Nature","Hajj and Umrah","Good Etiquette","Food _ Drink"]
        // arraySupplicationtitle = [dict["All"]! as! String,dict["Morning_Evening"]! as! String,dict["Travel"]! as! String,dict["Home_Family"]! as! String,dict["Joy_Distress"]! as! String,dict["prayer"]! as! String,"Praising Allah","Nature","Haji and Umrah","Good Etiquette","Food & Drink"]
        
          arraySupplicationtitle = [dict["All"]! as! String,dict["Morning_Evening"]! as! String,dict["Travel"]! as! String,dict["Home_Family"]! as! String,dict["Joy_Distress"]! as! String,dict["prayer"]! as! String,dict["Praising_Allah"]! as! String,dict["Nature"]! as! String,dict["haji_umrah"]! as! String,dict["Good_Etiquette"]! as! String,dict["Food_Drink"]! as! String]
        
        collectionintro.register(UINib(nibName: "SupplicationCell", bundle: nil), forCellWithReuseIdentifier: "SupplicationCell")
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    func setViews()
    {
       let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                  print(dict)
              appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Supplication"]!))
        
        self.supplicationlistApi()
        
        
    }
    func supplicationlistApi(){
        customLoader.show()
       
        
        
      
        
        
        let urlPath =  "http://167.172.131.53:4002/api/supplication/getAllCategory"
        
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arraysupplication = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arraysupplication);
                self.collectionintro.reloadData()
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraysupplication.count+1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SupplicationCell", for: indexPath as IndexPath) as! SupplicationCell
      
        
        
        
        
        
        
        if (indexPath.row == 0){
            cell.lblTitle.text = "All"
            cell.imgSupplication.image = UIImage(named: "All")
        }
        else {
            let diccat = arraysupplication.object(at: indexPath.row-1) as! JSON
            
            print(diccat)
        cell.lblTitle.text = diccat["name"].stringValue
            
             cell.imgSupplication.image =  UIImage(named: arraySupplicationimg[indexPath.row-1])
        
        
     //   let profile : String =  "http://139.59.83.155:4002\(diccat["iconUrl"].stringValue)"
       // print(profile)
       // cell.imgSupplication.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
        }
        
        
        
        
        
        
        
        return cell
        
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
         return CGSize(width:110,height:110)
        
        //}
        
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if (indexPath.row == 0){
            let callVC = ViewControllerHelper.getViewController(ofType: .Supplicationdetail)
            
            UserDefaults.standard.set("All", forKey: "supCategory_id")
            self.navigationController?.pushViewController(callVC, animated: true)
        }
         else {
        
        let diccat = arraysupplication.object(at: indexPath.row-1) as! JSON
        
        print(diccat)
        
        let callVC = ViewControllerHelper.getViewController(ofType: .Supplicationdetail)
        
        UserDefaults.standard.set(diccat["supCategory_id"].stringValue, forKey: "supCategory_id")
        self.navigationController?.pushViewController(callVC, animated: true)
        
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
