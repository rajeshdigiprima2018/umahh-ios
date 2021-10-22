//
//  QuizResultVC.swift
//  Umahh
//
//  Created by mac on 08/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuizResultVC: UIViewController {
    
      @IBOutlet weak var lblCorrect: UILabel!
     @IBOutlet weak var lblWrong: UILabel!
    
      @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var btnCorrect: UIButton!
    @IBOutlet weak var btnWrong: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
        
        btnCorrect.setTitle((dict["Correct_Answer"]!), for: .normal)
         btnWrong.setTitle((dict["Wrong_Answer"]!), for: .normal)
         btnReply.setTitle((dict["reply"]!), for: .normal)
        
        let strRightValue2:String = UserDefaults.standard.object(forKey: "strRightValue") as! String
        print(strRightValue2)
        
        let strWrongValue2:String = UserDefaults.standard.object(forKey: "strWrongValue") as! String
        print(strWrongValue2)
        
        lblCorrect.text = strRightValue2
          lblWrong.text = strWrongValue2

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
        
        
        let quiztitle:String = UserDefaults.standard.object(forKey: "quiztitle") as! String
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: quiztitle)
     
        
        
        
    }
    
    @IBAction func playClicked(_ sender: Any) {
        self.navigationController!.pushViewController(HomeVC(nibName: "HomeVC", bundle: nil), animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
