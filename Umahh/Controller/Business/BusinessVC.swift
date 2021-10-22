//
//  BusinessVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BusinessVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionBusiness: UICollectionView!
    
    var arraySupplicationimg = [String]()
    var arraySupplicationtitle = [String]()
    @IBOutlet weak var viewSearch: UIView!
     var arraybusiness = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arraySupplicationimg = ["Book Business icon","Religion Clothing","Insence business"]
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                  print(dict)
        
        
        arraySupplicationtitle = [(dict["Book_business"]!),(dict["Religion_clothing"]!),(dict["Incense_Business"]!)]
        
      
        
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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Business"]!))
         appDelegate.setRoundRectAndBorderColor(view: viewSearch, color: UIColor.clear, width: 0.0, radious: 3.0)
        
          collectionBusiness.register(UINib(nibName: "SupplicationCell", bundle: nil), forCellWithReuseIdentifier: "SupplicationCell")
        self.businesslistApi()
        
    }
    func businesslistApi(){
        customLoader.show()
       
     
        
        
        let urlPath =  "http://167.172.131.53:4002/api/business/getAllCategory"

        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arraybusiness = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arraybusiness);
                self.collectionBusiness.reloadData()
                
                
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
        return arraybusiness.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SupplicationCell", for: indexPath as IndexPath) as! SupplicationCell
    cell.imgSupplication.image = UIImage(named: arraySupplicationimg[indexPath.row])
       
        
        let diccat = arraybusiness.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lblTitle.text = diccat["name"].stringValue
        
       // cell.lblTitle.text = arraySupplicationtitle[indexPath.row]
        
        
//        let profile : String =  "http://139.59.83.155:4002\(diccat["iconUrl"].stringValue)"
//        print(profile)
//        cell.imgSupplication.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "default.png"))
        
        
        
        
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        return CGSize(width:100,height:100)
        
        //}
        
        
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let diccat = arraybusiness.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let callVC = ViewControllerHelper.getViewController(ofType: .businessdetail)
        
        UserDefaults.standard.set(diccat["category_id"].stringValue, forKey: "category_id")
         UserDefaults.standard.set(diccat["name"].stringValue, forKey: "business_title")
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
   
    
   
    
}
