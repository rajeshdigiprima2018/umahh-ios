//
//  ActivityList.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ActivityList: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    @IBOutlet var collectionActivity: UICollectionView!
   var arrayActivity = NSArray();
    var mosqueid:String = ""
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Activities"]!))
        
        
        collectionActivity.register(UINib(nibName: "ActivityCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCell")
        self.ActivityApi()
    }
    
    func ActivityApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
      //  let urlPath =  "http://139.59.83.155:4002/api/mosque/Activities/getAll/5c88c59990361c17a8600e80"

        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/Activities/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayActivity = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayActivity);
                self.collectionActivity.reloadData()
                
                
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
        return arrayActivity.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ActivityCell", for: indexPath as IndexPath) as! ActivityCell
       
        
        let diccat = arrayActivity.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lbltext.text = diccat["title"].stringValue
        
       // if (diccat["pictures"].dictionary != nil) {
            
            let imagdata = diccat["pictures"].arrayValue
           print(imagdata)
        
        let url = imagdata[0]
        
       let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                   print(dict)
        
        cell.btnMore.setTitle((dict["View_More"]!), for: .normal)
        
       
        let profile : String =  "http://167.172.131.53:4002\(url["url"])"
        print(profile)
         cell.imgActivity.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
        
        //}
        
        
        
        
        
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        return CGSize(width:165,height:180)
        
        //}
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Cell: \(indexPath.row)")
        
        let diccat = arrayActivity.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
         UserDefaults.standard.set(diccat["id"].stringValue, forKey: "activity_id")
        
        let callVC = ViewControllerHelper.getViewController(ofType: .activitiesDetail)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
