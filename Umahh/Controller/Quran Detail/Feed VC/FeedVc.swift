//
//  FeedVc.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class FeedVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblFeed: UITableView!
    
    var arrayFeed = NSArray();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblFeed.estimatedRowHeight = 300.0
        tblFeed.rowHeight = UITableViewAutomaticDimension

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
         appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: "Today's Feed")
       
       
        
        tblFeed.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.feedlistApi()
    }
    
    func feedlistApi(){
        customLoader.show()
       
        
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        //let urlPath =  "http://139.59.83.155:4002/api/mosque/News/getAll/5c88c59990361c17a8600e80"
        
        
        let urlPath =  "http://167.172.131.53:4002/api/todaysFeed/getAll"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayFeed = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayFeed);
                self.tblFeed.reloadData()
                
                
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
        return arrayFeed.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 300
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let diccat = arrayFeed.object(at: indexPath.row) as! JSON
        
        print(diccat)
     //   cell.lblmosquename.text = diccat["textarea"].stringValue
        cell.lblname.text = diccat["title"].stringValue
        
        
        
        let content =  diccat["textarea"].stringValue
        
        
        
        let htmlData = NSString(string: content).data(using: String.Encoding.unicode.rawValue)
        
        let options =  [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        
        
        
        
        let attributedString = try!  NSMutableAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        print(attributedString)
        
        
        
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14) , range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
       
        
        cell.lbltext.attributedText = attributedString
        cell.lbltext.tintColor = UIColor.white
        
        //cell.lbltext.at =  UIColor.gray
        
//        cell.lbltext.linkAttributes = [
//            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
//            NSAttributedStringKey.underlineColor: NSUnderlineStyle.styleNone
//
//        ]
        
//         cell.lbltext.l = [
//            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
//        ]
//         cell.lbltext.linkAttributes = [NSAttributedStringKey.underlineColor.rawValue: UIColor.clear]
        
        let imgcontent = diccat["avtar"].stringValue
        print(imgcontent)
        
        let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
        print(avtar)
        cell.imgProfile.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "user_default"))
        
        let imagdata = diccat["pictures"].arrayValue
        print(imagdata)
        
        let url = imagdata[0]
        
        
        
        
        
        
        let profile : String =  "http://167.172.131.53:4002\(url["url"])"
        print(profile)
        cell.imgFeed.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "mosque_default"))
        
       // cell.lblname.text =  "By \(diccat["byName"].stringValue)"
        
        
        let mosquedata = diccat["mosque_id"]
        print(mosquedata)
        
       
        
       cell.lblmosquename.text = mosquedata["username"].stringValue
        
        cell.selectionStyle = .none
        return cell
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
