//
//  CalendorVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CalendorVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var tblCalendor: UITableView!
     @IBOutlet weak var ViewCalendro: UIView!
     @IBOutlet weak var lblDate: UILabel!
    
      @IBOutlet weak var lblYear: UILabel!
    
     @IBOutlet weak var viewPopup: UIView!
     @IBOutlet weak var txtTitle: UITextView!
    var mosqueid:String = ""
    var arrayCalendor = NSArray();
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var monthLabel: UILabel!
    var selectedDate: Date!
    var eventDate: Date!
    var selecteventDate: Date!
    var calendarManager : CalendarManager!
    var dayOffset : Int!
    
      @IBOutlet weak var btnNext: UIButton!
    
      @IBOutlet weak var btnPrevious: UIButton!
    
     var dict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         appDelegate.setRoundRectAndBorderColor(view: ViewCalendro, color: UIColor.clear, width: 0.0, radious: 10.0)
        
        calendarManager = CalendarManager()
        print(calendarManager.currentMonth!);
        print(calendarManager.currentMonthAndYear());
        //self.monthLabel.text = calendarManager.currentMonthAndYear()
        
        selectedDate = Date()
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1)%7
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        if indexPath.section == 0{
            cell.dateLabel.text = calendarManager.stringForDay(indexPath.row)
            cell.eventView.isHidden = true
        }else if indexPath.section == 1{
            if indexPath.row < dayOffset{
                cell.dateLabel.text = ""
                cell.eventView.isHidden = true
                
                return cell
            }
            cell.eventView.isHidden = true
            let date = indexPath.row - dayOffset + 1
            print(dateForIndexPath(indexPath: indexPath))
            
            eventDate = dateForIndexPath(indexPath: indexPath)
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = df.string(from: eventDate)
            print(now)
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let showDate = inputFormatter.date(from: now)
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            
            for  i in 0 ..< self.arrayCalendor.count {
                // self.selectInterestArray.add("0")
                
                print(i)
                let diccat = arrayCalendor[i] as! JSON
                print(diccat)
                
                let startdateContent = diccat["calendarDate"].stringValue
                
                let startdateArr = startdateContent.components(separatedBy: ".")
                
                let startdate    = startdateArr[0]
                
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let showDate = inputFormatter.date(from: startdate)
                print(showDate!)
                inputFormatter.dateFormat = "yyyy-MM-dd"
                let startdateString = inputFormatter.string(from: showDate!)
                print(startdateString)
                
             
                
                if startdateString as String == resultString {
                    cell.eventView.isHidden = false
                }
                else {
                    //cell.eventView.isHidden = true
                }
                
            }
            
            cell.dateLabel.text = NSString(format: "%d", date) as String
            
            // cell.dateLabel.text = dateForIndexPath(indexPath: indexPath) as String
            
        }
        
        if indexPath == indexPathFor(date:Date()){
          
             cell.selectionView.backgroundColor = UIColor.red
            cell.dateLabel.textColor = UIColor.black
        }else if indexPath == indexPathFor(date:selectedDate){
          
             cell.selectionView.backgroundColor = UIColor.red
            cell.dateLabel.textColor = UIColor.black
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
        }else{
            cell.selectionView.backgroundColor = UIColor.clear
            cell.dateLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 7
        }else{
            return calendarManager.numberOfDaysInMonth() + dayOffset
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if dayOffset > indexPath.row || indexPath.section == 0{
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
       
        selectedDate = dateForIndexPath(indexPath: indexPath)
        print(selectedDate!)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: selectedDate)
       
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let showDate = inputFormatter.date(from: now)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
      
        
        
        for  i in 0 ..< self.arrayCalendor.count {
            // self.selectInterestArray.add("0")
            
            print(i)
            let diccat = self.arrayCalendor[i] as! JSON
          
            
             let startdateContent = diccat["calendarDate"].stringValue
          
            
            let inputFormatter1 = DateFormatter()
            inputFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let showDate1 = inputFormatter1.date(from: startdateContent)
            inputFormatter1.dateFormat = "yyyy-MM-dd"
            let resultString1 = inputFormatter1.string(from: showDate1!)
           
            if resultString1 as String  == resultString {
                print("YES")
                
                 viewPopup.isHidden = false
                
                txtTitle.text = diccat["title"].stringValue
                print(startdateContent)
               
            }
            else {
                print("NO")
              
            }
        }
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DateCell", for: indexPath as IndexPath) as! DateCell
        
       
        
        if indexPathFor(date:Date()) == indexPath{
            
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:83/256, green:213/256, blue:42/256, alpha:1.0)
        }else{
            
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:154/256, green:154/256, blue:154/256, alpha:1.0)
        }
    }
    
    @IBAction func hidepopClicked(_ sender: Any) {
        viewPopup.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       // let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DateCell", for: indexPath as IndexPath) as! DateCell
        
        if indexPathFor(date:Date()) == indexPath{
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:83/256, green:213/256, blue:42/256, alpha:1.0)
        }else{
            cell.dateLabel.textColor = UIColor.black
            cell.selectionView.backgroundColor = UIColor.clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = collectionView.frame.width/7
        return CGSize(width: size-2, height: size-2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    @IBAction func gotoPreviousMonth(_ sender: AnyObject) {
        previousMonth()
    }
    
    @IBAction func gotoNextMonth(_ sender: AnyObject) {
        nextMonth()
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.right{
            previousMonth()
        }else{
            nextMonth()
        }
    }
    
    private func nextMonth(){
       
        calendarManager.offsetMonths(1)
     // appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: calendarManager.currentMonthAndYear())
        
        lblDate.text = calendarManager.currentMonthAndYear()
        
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1) % 7
        collectionView.reloadData()
    }
    
    private func previousMonth(){
       
        calendarManager.offsetMonths(-1)
      
        
        lblDate.text = calendarManager.currentMonthAndYear()
        
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1) % 7
        collectionView.reloadData()
    }
    
    private func indexPathFor(date : Date) -> IndexPath? {
        if calendarManager.monthForDate(date: date) != calendarManager.monthForDate(date: calendarManager.currentMonth) || calendarManager.yearForDate(date: date) != calendarManager.yearForDate(date: calendarManager.currentMonth){
            return nil
        }
        let day = calendarManager.dayForDate(date: date)
        return IndexPath(row:day + (dayOffset - 1), section:1)
    }
    
    private func dateForIndexPath(indexPath : IndexPath) -> Date {
        let day = indexPath.row - (dayOffset - 1)
        let month = calendarManager.monthForDate(date:calendarManager.currentMonth)
        let year = calendarManager.yearForDate(date:calendarManager.currentMonth)
        return calendarManager.date(day: day, month: month, year: year)
    }
    
    private func isCurrentMonth() -> Bool{
        if calendarManager.monthForDate(date: selectedDate) == calendarManager.monthForDate(date: calendarManager.currentMonth) && calendarManager.yearForDate(date: selectedDate) == calendarManager.yearForDate(date: calendarManager.currentMonth){
            return true
        }else{
            return false
        }
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
    }
    
    func setViews()
    {
        
         collectionView.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        
        let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
               print(dict)
        
        btnNext.setTitle((dict["next"]!), for: .normal)
         btnPrevious.setTitle((dict["Previous"]!), for: .normal)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Calendar"]!))
        
        print(calendarManager.currentMonthAndYear())
        
        lblDate.text = calendarManager.currentMonthAndYear()
        
        
        tblCalendor.register(UINib(nibName: "CalenderCell", bundle: nil), forCellReuseIdentifier: "CalenderCell")
        self.baordlistApi()
    }
    
    func baordlistApi(){
        customLoader.show()
//        let mosqueid:String = UserDefaults.standard.object(forKey: "sel_mosque_id") as! String
        print(mosqueid)
        
        
       

        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/Calendar/getAll/\(mosqueid)"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayCalendor = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayCalendor);
                self.tblCalendor.reloadData()
                 self.collectionView.reloadData()
                
                
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
        return arrayCalendor.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        
        let diccat = arrayCalendor.object(at: indexPath.row) as! JSON
        
        print(diccat)
        cell.lblTitle.text = diccat["title"].stringValue
      //cell.lbltime.text = diccat["calendarTime"].stringValue
        
        let startdateContent = diccat["calendarDate"].stringValue
        
        let startdateArr = startdateContent.components(separatedBy: ".")
        
        let startdate    = startdateArr[0]
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let showDate = inputFormatter.date(from: startdate)
        print(showDate!)
        inputFormatter.dateFormat = "EEE dd MMM YYYY"
        let startdateString = inputFormatter.string(from: showDate!)
        print(startdateString)
        
        cell.lbltime.text = startdateString
       
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

}
