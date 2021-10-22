//
//  QuizList.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuizList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                      print(dict)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Quiz"]!))
        tblQuiz.register(UINib(nibName: "QuizCell", bundle: nil), forCellReuseIdentifier: "QuizCell")
        
        self.QuizlistApi()
        
    }
    
    func QuizlistApi(){
        customLoader.show()
      
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/News/getAll/5c88c59990361c17a8600e80"
        
        
        let urlPath =  "http://167.172.131.53:4002/api/quiz/Category/getAll"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayQuiz = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayQuiz);
                self.tblQuiz.reloadData()
                
                
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
        return arrayQuiz.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizCell
        let diccat = arrayQuiz.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lblQuiz.text = diccat["title"].stringValue
        cell.selectionStyle = .none
        return cell
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
      
        let diccat = arrayQuiz.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
         let quiztitle = diccat["title"].stringValue
        
            let quiz_category_id = diccat["quiz_category_id"].stringValue
        
          UserDefaults.standard.set(quiztitle, forKey: "quiztitle")
        
          UserDefaults.standard.set(quiz_category_id, forKey: "quiz_category_id")
        self.navigationController!.pushViewController(QuizDetail(nibName: "QuizDetail", bundle: nil), animated: true)
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
