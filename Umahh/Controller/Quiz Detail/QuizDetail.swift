//
//  QuizDetail.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuizDetail: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arrayQuiz = NSArray();
     var strRightValue = Int();
    var strWrongValue = Int();
     var selectAnsArray = NSMutableArray();
    
     var yourAnsArray = NSMutableArray();
    
      var strtype = NSString();
    
     @IBOutlet weak var btnDone: UIButton!
    
    
    @IBOutlet weak var tblQuiz: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strRightValue = 0
         strWrongValue = 0
        strtype = "load"
        
        tblQuiz.estimatedRowHeight = 195.0
        tblQuiz.rowHeight = UITableViewAutomaticDimension
        
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
        
        btnDone.setTitle((dict["Done"]!), for: .normal)
          let quiztitle:String = UserDefaults.standard.object(forKey: "quiztitle") as! String
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: quiztitle)
        tblQuiz.register(UINib(nibName: "QuizQuesAnsCell", bundle: nil), forCellReuseIdentifier: "QuizQuesAnsCell")
        
        self.QuizlistApi()
        
    }
    
    func QuizlistApi(){
        customLoader.show()
        
        
        
        let quiz_category_id:String = UserDefaults.standard.object(forKey: "quiz_category_id") as! String
        print(quiz_category_id)
        
        
        let urlPath =  "http://167.172.131.53:4002/api/quiz/getAll/\(quiz_category_id)"
        
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
                  print(self.arrayQuiz.count);
                
                for _ in 0 ..< self.arrayQuiz.count {
                    self.selectAnsArray.add("0")
                    self.yourAnsArray.add("A:Blank")
                }
                print(self.selectAnsArray)
                
                
                
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
      return 280
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizQuesAnsCell", for: indexPath) as! QuizQuesAnsCell
        let diccat = arrayQuiz.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let selectValue = selectAnsArray.object(at: indexPath.row) as! NSString
        print(selectValue)
        let answer = diccat["answer"].stringValue
        cell.btnAns1.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cell.btnAns2.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cell.btnAns3.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cell.btnAns4.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        if selectValue == "0" {
            cell.btnAns1.isSelected = false
             cell.btnAns2.isSelected = false
             cell.btnAns3.isSelected = false
            cell.btnAns4.isSelected = false
            
        }
        else if selectValue == "1" {
            cell.btnAns1.isSelected = true
            cell.btnAns2.isSelected = false
            cell.btnAns3.isSelected = false
            cell.btnAns4.isSelected = false
            if diccat["answer"].stringValue == diccat["option1"].stringValue {
                cell.btnAns1.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
                
            }
            else {
                cell.btnAns1.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
                
            }
        }
        else if selectValue == "2" {
            cell.btnAns1.isSelected = false
            cell.btnAns2.isSelected = true
            cell.btnAns3.isSelected = false
            cell.btnAns4.isSelected = false
            if diccat["answer"].stringValue == diccat["option2"].stringValue {
                cell.btnAns2.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            }
            else {
                cell.btnAns2.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
            }
        }
        else if selectValue == "3" {
            cell.btnAns1.isSelected = false
            cell.btnAns2.isSelected = false
            cell.btnAns3.isSelected = true
            cell.btnAns4.isSelected = false
            if diccat["answer"].stringValue == diccat["option3"].stringValue {
                cell.btnAns3.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            }
            else {
                cell.btnAns3.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
            }
        }
        else if selectValue == "4" {
            cell.btnAns1.isSelected = false
            cell.btnAns2.isSelected = false
            cell.btnAns3.isSelected = false
            cell.btnAns4.isSelected = true
            if diccat["answer"].stringValue == diccat["option4"].stringValue {
                cell.btnAns4.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            }
            else {
                cell.btnAns4.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
            }
        }
        
        cell.lblQuestion.text = diccat["question"].stringValue
        
          let option1 = diccat["option1"].stringValue
        
          let option2 = diccat["option2"].stringValue
        
          let option3 = diccat["option3"].stringValue
        
          let option4 = diccat["option4"].stringValue
        
        cell.btnAns1.setTitle(option1, for: .normal)
          cell.btnAns2.setTitle(option2, for: .normal)
          cell.btnAns3.setTitle(option3, for: .normal)
          cell.btnAns4.setTitle(option4, for: .normal)
        
        cell.btnAns1.tag = indexPath.row
        cell.btnAns1.addTarget(self, action: #selector(self.btnAns1Action(_:)), for: .touchUpInside)
        
        cell.btnAns2.tag = indexPath.row
        cell.btnAns2.addTarget(self, action: #selector(self.btnAns2Action(_:)), for: .touchUpInside)
        
        cell.btnAns3.tag = indexPath.row
        cell.btnAns3.addTarget(self, action: #selector(self.btnAns3Action(_:)), for: .touchUpInside)
        
        cell.btnAns4.tag = indexPath.row
        cell.btnAns4.addTarget(self, action: #selector(self.btnAns4Action(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
      @objc func btnAns1Action(_ sender: UIButton) {
        print(sender.tag)
        let diccat = arrayQuiz.object(at: sender.tag) as! JSON
        
        print(diccat)
        
         let option = diccat["option1"].stringValue
        
        
        print(option)
       
        
     
        
        if sender.isSelected {
            sender.isSelected = false
              yourAnsArray.replaceObject(at: sender.tag, with: "Blank")
             self.selectAnsArray.replaceObject(at: sender.tag, with: "0")
        }
        else {
             sender.isSelected = true
            yourAnsArray.replaceObject(at: sender.tag, with: option)
              self.selectAnsArray.replaceObject(at: sender.tag, with: "1")
        }
        print(self.yourAnsArray)
         print(self.selectAnsArray)
        tblQuiz.reloadData()
        
    }
    
    @objc func btnAns2Action(_ sender: UIButton) {
        
        let diccat = arrayQuiz.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        let option = diccat["option2"].stringValue
        
      
        print(option)
      
        
      
        if sender.isSelected {
            sender.isSelected = false
             yourAnsArray.replaceObject(at: sender.tag, with: "Blank")
              self.selectAnsArray.replaceObject(at: sender.tag, with: "0")
        }
        else {
            sender.isSelected = true
           
              yourAnsArray.replaceObject(at: sender.tag, with: option)
              self.selectAnsArray.replaceObject(at: sender.tag, with: "2")
        }
        print(self.yourAnsArray)
        print(self.selectAnsArray)
        tblQuiz.reloadData()
    }
    
    @objc func btnAns3Action(_ sender: UIButton) {
        
        let diccat = arrayQuiz.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        let option = diccat["option3"].stringValue
        
       
        print(option)
       
        
        if sender.isSelected {
            sender.isSelected = false
              yourAnsArray.replaceObject(at: sender.tag, with: "Blank")
              self.selectAnsArray.replaceObject(at: sender.tag, with: "0")
        }
        else {
            sender.isSelected = true
              yourAnsArray.replaceObject(at: sender.tag, with: option)
              self.selectAnsArray.replaceObject(at: sender.tag, with: "3")
        }
        print(self.yourAnsArray)
        print(self.selectAnsArray)
        tblQuiz.reloadData()
    }
    
    @objc func btnAns4Action(_ sender: UIButton) {
        
        let diccat = arrayQuiz.object(at: sender.tag) as! JSON
        
        print(diccat)
        
        let option = diccat["option4"].stringValue
        
       
        print(option)
       
        
        if sender.isSelected {
            sender.isSelected = false
              yourAnsArray.replaceObject(at: sender.tag, with: "Blank")
              self.selectAnsArray.replaceObject(at: sender.tag, with: "0")
        }
        else {
              yourAnsArray.replaceObject(at: sender.tag, with: option)
            sender.isSelected = true
              self.selectAnsArray.replaceObject(at: sender.tag, with: "4")
        }
        print(self.yourAnsArray)
        print(self.selectAnsArray)
        tblQuiz.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
     
    }
    
    @IBAction func playClicked(_ sender: Any) {
        print(yourAnsArray)
         for i in 0 ..< self.arrayQuiz.count {
            print(i)
            
            let diccat = arrayQuiz.object(at: i) as! JSON
            
            print(diccat)
            
        let useransValue = yourAnsArray.object(at: i) as! NSString
        print(useransValue)
            
//           // let fullName    = "First Last"
//            let fullNameArr = useransValue.components(separatedBy: ":")
//
//            let firstindex    = fullNameArr[0]
//            let lastindex = fullNameArr[1]
//            print(firstindex)
//             print(lastindex)
        
        let quizans = diccat["answer"].stringValue
        print(quizans)
            
//            let quizansArr = quizans.components(separatedBy: ":")
//
//            let quizansindex    = quizansArr[0]
//            let quizanslastindex = quizansArr[1]
//            print(quizansindex)
//            print(quizanslastindex)
            
        
            if useransValue as String == quizans {
            strRightValue = strRightValue + 1
        }
        else   {
            strWrongValue = strWrongValue + 1
        }
        }
        
      
        print(strRightValue)
         print(strWrongValue)

        
        let x : Int = strRightValue
        let strRightValue1 = String(x)
        
        let x1 : Int = strWrongValue
        let strWrongValue1 = String(x1)
        
      
         UserDefaults.standard.set(strRightValue1, forKey: "strRightValue")
         UserDefaults.standard.set(strWrongValue1, forKey: "strWrongValue")
        
        let strRightValue2:String = UserDefaults.standard.object(forKey: "strRightValue") as! String
        print(strRightValue2)
        
        let strWrongValue2:String = UserDefaults.standard.object(forKey: "strWrongValue") as! String
        print(strWrongValue2)
        
        self.navigationController!.pushViewController(QuizResultVC(nibName: "QuizResultVC", bundle: nil), animated: true)
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
