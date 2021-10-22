//
//  IntroVC.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit



class IntroVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionintro: UICollectionView!
    
     var arrayIntroimg = [String]()
    
     var dictRoot: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         arrayIntroimg = ["WT 1","WT 2","WT 3"]
        
        collectionintro.register(UINib(nibName: "IntroCell", bundle: nil), forCellWithReuseIdentifier: "IntroCell")
        
      
        if let path = Bundle.main.path(forResource: "Lang", ofType: "plist") {
            dictRoot = NSDictionary(contentsOfFile: path)
            print(dictRoot!)
            
             print(dictRoot!["en"] as! NSDictionary)
            
            UserDefaults.standard.set(dictRoot!["en"] as! NSDictionary, forKey: "dict")
                        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                       print(dict)
        }

       
        
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
        
       // appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "")
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"IntroCell", for: indexPath as IndexPath) as! IntroCell
         cell.imgBg.image = UIImage(named: arrayIntroimg[indexPath.row])
       // let cell : introCell = collectionintro.dequeueReusableCell(withReuseIdentifier: "introCell", for: indexPath) as! introCell
        if (indexPath.row == 0 )
        {
        
            cell.lblTitle.text = "السلام عليكم"
            cell.lblDescription.text = "مرحبا بك .أنت الآن تقوم بتسجيل الدخول إلى مسجدك المحلي ...فضلا قم بتسجيلك، ثم الاختيار"
        }
        else  if (indexPath.row == 1 )
        {
            cell.lblTitle.text = "Assalam Aleikoum"
            cell.lblDescription.text = "Vous êtes en cour de vous connecter maintenant à vos Mosquées locales... Inscrivez-vous et Sélectionnez"
        }
        else  if (indexPath.row == 2 )
        {
            cell.lblTitle.text = "Assalam Aleikoum"
            cell.lblDescription.text = "You are now connecting to your local mosques… Sign up and select"
        }
        
        
        if dictRoot != nil
               {
                   // Your dictionary contains an array of dictionary
                   // Now pull an Array out of it.
                   let arrayList:[NSDictionary] = [dictRoot?["en"] as! NSDictionary]
                   print(arrayList)
                  
                   arrayList.forEach({ (dict) in
                       
                        print(dict)
                    
                    let skiptitle = dict["skip"]!
                      let logintitle = dict["Log_in"]!
                      let signuptitle = dict["Signup"]!
                    print(skiptitle)
                     print(logintitle)
                     print(signuptitle)
                    
                    
                    cell.btnSkip.setTitle(skiptitle as? String, for: .normal)
                    cell.btnSignup.setTitle(signuptitle as? String, for: .normal)
                    cell.btnLogin.setTitle(logintitle as? String, for: .normal)
                       
                      // print("Category Name \(dict["category_name"]!)")
                      // print("Category Id \(String(describing: dict["cid"]))")
                   })
               }
        
        
        cell.btnLogin.tag = indexPath.row
        cell.btnLogin.addTarget(self, action: #selector(self.loginButtonPressed(_:)), for: .touchUpInside)
        
        cell.btnSignup.tag = indexPath.row
        cell.btnSignup.addTarget(self, action: #selector(self.SignupnButtonPressed(_:)), for: .touchUpInside)
        
        cell.btnSkip.tag = indexPath.row
        cell.btnSkip.addTarget(self, action: #selector(self.skipButtonPressed(_:)), for: .touchUpInside)
        
        
        
        
        
        
        
        return cell
        
    }
    
    @objc func skipButtonPressed(_ sender: UIButton)
    {
        UserDefaults.standard.set("Login", forKey: "nameContactPerson")
        UserDefaults.standard.set("", forKey: "email")
        UserDefaults.standard.set("", forKey: "avtar")
        let callVC = ViewControllerHelper.getViewController(ofType: .home)
        self.navigationController?.pushViewController(callVC, animated: true)
        
       // let callVC = ViewControllerHelper.getViewController(ofType: .selectmosque)
       // self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    @objc func loginButtonPressed(_ sender: UIButton)
    {
        let callVC = ViewControllerHelper.getViewController(ofType: .loginVC)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @objc func SignupnButtonPressed(_ sender: UIButton)
    {
       
        let callVC = ViewControllerHelper.getViewController(ofType: .accounttypeVC)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
       // return CGSize(width:123,height:150)
        
        //}
        
        
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
