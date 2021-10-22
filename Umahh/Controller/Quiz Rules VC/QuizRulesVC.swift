//
//  QuizRulesVC.swift
//  Umahh
//
//  Created by mac on 08/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuizRulesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arrayQuiz = NSArray();
    
    @IBOutlet weak var tblQuiz: UITableView!
    
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
           
        
          let quiztitle:String = UserDefaults.standard.object(forKey: "quiztitle") as! String
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: quiztitle)
        tblQuiz.register(UINib(nibName: "QuizRulesCell", bundle: nil), forCellReuseIdentifier: "QuizRulesCell")
        
      
        
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "QuizRulesCell", for: indexPath) as! QuizRulesCell
        
           cell.lblindexno.text = "\(indexPath.row+1)"
       
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func BackBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func playClicked(_ sender: Any) {
        self.navigationController!.pushViewController(QuizDetail(nibName: "QuizDetail", bundle: nil), animated: true)
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
