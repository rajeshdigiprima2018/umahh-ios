//
//  ForgotVC.swift
//  Charged
//
//  Created by DevD on 09/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
//import SDWebImage
//import SwiftyJSON

 //var sections = [Section]()

struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!

    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed

    }
}
@objc protocol SideMenuDelegae{
    @objc optional func CommonfunctionForSideMenuDelegate(text:String)
}

class SideMenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  var delegate:SideMenuDelegae?
     var sections = [Section]()
    var arrayCategoryimg = [String]()
    @IBOutlet var tblMenu: UITableView!
    
     var strnotitype = NSString();
    
   
    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    let selectedStar = UIImage(named: "selectedStar")
    let unSelectedStar = UIImage(named: "unSelected")
    
    
    func logoutasession() {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"logout")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        arrayCategoryimg = [
            "Bookmark fill",
            "Donation fill",
            "Todays Feed fill",
           "Quran Fill",
            "Community fill",
            "settings fill",
            "Qiblah fill",
            "Quiz Fill",
            "Personnage fi",
            "Hajj_Umrah_menu",
            "Supplication_menu"
        ]
        
          let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
        print(dict)
       
        sections = [
            Section(name: (dict["Bookmark"]!), items: []),
            Section(name: (dict["Donation"]!), items: []),
            Section(name: (dict["Today_Feed"]!), items: []),
//            Section(name: (dict["Quran"]!), items: []),
            Section(name: (dict["Community"]!), items: []),
            Section(name: (dict["Settings"]!), items: []),
            Section(name: (dict["Qiblah"]!), items: []),
            Section(name: (dict["Quiz"]!), items: []),
//            Section(name: (dict["Personage"]!), items: []),
            Section(name: (dict["haji_umrah"]!), items: []),
            Section(name: (dict["Supplication"]!), items: [])
        ]
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        let email:String = UserDefaults.standard.object(forKey: "email") as! String
        let nameContactPerson:String = UserDefaults.standard.object(forKey: "nameContactPerson") as! String
        let imgurl:String = UserDefaults.standard.object(forKey: "avtar") as! String
        print(imgurl)
        
        lblname.text = nameContactPerson
        lblEmail.text = email
        
//        let avtar : String =  "http://139.59.83.155:4002\(imgurl)"
//        print(avtar)
//        imguser.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "user_default"))
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        
        if (UserDefaults.standard.object(forKey: "imageData") != nil)
        {
        
        let uiImage: UIImage  =  UIImage(data: UserDefaults.standard.data(forKey: "imageData")!) ?? UIImage(named: "user")!
        self.imguser.image = uiImage
            self.imguser.layer.borderWidth = 2
            self.imguser.layer.cornerRadius = self.imguser.frame.size.width/2
            self.imguser.clipsToBounds = true
        }
        else {
            self.imguser.image = UIImage(named: "user")
        }
        }
        else {
             self.imguser.image = UIImage(named: "user")
        }
        
       
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"Home")
    }
    
    @objc func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
     @objc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return ""
        case 1:  return ""
        default: return ""
        }
    }
    
     @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        var count = sections.count
        for section in sections {
            count += section.items.count
        }
        return count
    }
    
     @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 0
        }
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        // Header has fixed height
        if row == 0 {
            return 60.0
        }
        
        return sections[section].collapsed! ? 0 : 44.0
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = getSectionIndex(indexPath.row)
        sections[section].collapsed = sections[section].collapsed
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell
        cell.menuTitleLabel.text = sections[section].name
        cell.toggleButton.tag = section
       cell.menuImageView.image = UIImage(named: arrayCategoryimg[indexPath.row])
        cell.toggleButton.isHidden = true
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
        if(indexPath.row == 0){
            if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
            {
            self.dismiss(animated: true, completion: nil)
           delegate?.CommonfunctionForSideMenuDelegate!(text:"Bookmark")
            }
            else {
               self.dismiss(animated: true, completion: nil)
            }
        }
        else if(indexPath.row == 1){
            if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
            {
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Donation")
            }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
        }
        
        else if(indexPath.row == 2){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Today's Feed")
        }
//        else if(indexPath.row == 3){
//            self.dismiss(animated: true, completion: nil)
//            delegate?.CommonfunctionForSideMenuDelegate!(text:"Quran")
//        }
        else if(indexPath.row == 3){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Community")
        }
        else if(indexPath.row == 4){
            self.dismiss(animated: true, completion: nil)
          delegate?.CommonfunctionForSideMenuDelegate!(text:"Settings")
        }
        else if(indexPath.row == 5){
             self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Qiblah")
       
        }
        else if(indexPath.row == 6){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Quize")
        }
//        else if(indexPath.row == 8){
//            self.dismiss(animated: true, completion: nil)
//           delegate?.CommonfunctionForSideMenuDelegate!(text:"Personnage")
//        }
        else if(indexPath.row == 7){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Haji")
        }
         else if(indexPath.row == 8){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Supplication")
        }
        else if(indexPath.row == 14){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Business")
        }
        else if(indexPath.row == 15){
            self.dismiss(animated: true, completion: nil)
            delegate?.CommonfunctionForSideMenuDelegate!(text:"Organization")
        }
    }
   
    @objc func toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed!
        
        let indices = getHeaderIndices()
        
        let start = indices[section]
        let end = start + sections[section].items.count
        
        tblMenu.beginUpdates()
        for i in start ..< end + 1 {
            tblMenu.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
        }
        tblMenu.endUpdates()
    }
    
    //
    // MARK: - Helper Functions
    //
    func getSectionIndex(_ row: NSInteger) -> Int {
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    func getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        
        return index
    }
    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        for section in sections {
            indices.append(index)
            index += section.items.count + 1
        }
        
        return indices
    }
   
    @IBAction func Homebtnclicked(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"profile")
        }
        else {
             self.dismiss(animated: true, completion: nil)
             delegate?.CommonfunctionForSideMenuDelegate!(text:"Login")
        }
    }
    
    @IBAction func SettingBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"setting")
    }
    
    @IBAction func HelpbtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        delegate?.CommonfunctionForSideMenuDelegate!(text:"help")
    }
    
    @IBAction func finacialBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"finance")
    }
    
    
    @IBAction func LawBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"law")
    }
    
    @IBAction func PromotionBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"promotions")
    }
    
    
    @IBAction func LogoutBtnClicked(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "YES", style: .default, handler: { (action) -> Void in
            print("Ok button click...")
            UserDefaults.standard.set(nil, forKey: "isLoggedIn")
            self.logoutasession()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "NO,THANKS", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func LoginbtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.CommonfunctionForSideMenuDelegate!(text:"login")
        
    }

}
//}
