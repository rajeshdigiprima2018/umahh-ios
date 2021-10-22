//
//  JuzDetailVC.swift
//  Umahh
//
//  Created by mac on 16/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import CRNotifications

class JuzDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblQuranDetail: UITableView!
    
    var arrayQuranDetail = NSArray();
    var arrayQuranDetailEn = NSArray();
    var strindex = Int();
    var player = AVPlayer()
    var selectSongArray = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strindex = 0;
        
        //   NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        
        tblQuranDetail.estimatedRowHeight = 82.0
        tblQuranDetail.rowHeight = UITableViewAutomaticDimension
        
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
        
        
        let Juz_name:String = UserDefaults.standard.object(forKey: "Juz_name") as! String
        print(Juz_name)
        
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: Juz_name)
        
        tblQuranDetail.register(UINib(nibName: "QuranDetailCell", bundle: nil), forCellReuseIdentifier: "QuranDetailCell")
        
        self.quranDetailListApi()
        
    }
    func quranDetailListApi(){
        
        customLoader.show()
        let catid:String = UserDefaults.standard.object(forKey: "number_id") as! String
        print(catid)
        
      //  let urlPath : String =  "http://api.alquran.cloud/v1/surah/\(catid)\("/ar.abdulbasitmurattal")"
        
        let quran_lang:String = UserDefaults.standard.object(forKey: "quran_lang") as! String
        print(quran_lang)
        
        
        let urlPath : String =  "http://api.alquran.cloud/v1/surah/\(catid)/\(quran_lang)"
        
        
        
        // let urlPath =  "http://api.alquran.cloud/v1/surah/1/en.asad"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                let alldata = swiftyJsonVar["data"]
                print(alldata)
                
                
                self.arrayQuranDetail = alldata["ayahs"].arrayValue as NSArray
                print(self.arrayQuranDetail);
                
                for _ in 0 ..< self.arrayQuranDetail.count {
                    self.selectSongArray.add("0")
                }
                print(self.selectSongArray)
                
                if self.arrayQuranDetail.count>0{
                    // self.tblQuranDetail.isHidden = false
                    // self.tblQuranDetail.reloadData()
                    self.quranDetailListEnApi()
                }
                else {
                    self.tblQuranDetail.isHidden = true
                }
                
                
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func quranDetailListEnApi(){
        
        customLoader.show()
        let numid:String = UserDefaults.standard.object(forKey: "number_id") as! String
        print(numid)
        
        
        
       // let urlPath : String =  "http://api.alquran.cloud/v1/surah/1/en.asad"
         let urlPath : String =  "http://api.alquran.cloud/v1/surah/\(numid)\("/en.asad")"
        
        
        // let urlPath =  "http://api.alquran.cloud/v1/surah/1/en.asad"
        
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                let alldata = swiftyJsonVar["data"]
                print(alldata)
                
                
                self.arrayQuranDetailEn = alldata["ayahs"].arrayValue as NSArray
                print(self.arrayQuranDetailEn);
                
                for _ in 0 ..< self.arrayQuranDetail.count {
                    self.selectSongArray.add("0")
                }
                print(self.selectSongArray)
                
                if self.arrayQuranDetailEn.count>0{
                    self.tblQuranDetail.isHidden = false
                    self.tblQuranDetail.reloadData()
                }
                else {
                    self.tblQuranDetail.isHidden = true
                }
                
                
                
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
        return arrayQuranDetail.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 80
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuranDetailCell", for: indexPath) as! QuranDetailCell
        
        
        let diccat = arrayQuranDetail.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        let diccaten = arrayQuranDetailEn.object(at: indexPath.row) as! JSON
        
        print(diccaten)
        
        
        
        cell.lblnameAr.text = diccat["text"].stringValue
        cell.lblname.text = diccaten["text"].stringValue
        cell.lblCount.text = diccat["number"].stringValue
        
        let selectValue = selectSongArray.object(at: indexPath.row) as! NSString
        print(selectValue)
        
        if selectValue == "0" {
            cell.viewMain.backgroundColor = UIColor.appGrayColor()
        }
        else {
            cell.viewMain.backgroundColor = UIColor.green
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let diccat = arrayQuranDetail.object(at: indexPath.row) as! JSON
        
        print(diccat)
        
        
    }
    
    
    @IBAction func playpauseClicked(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
            player.pause()
            
        }
        else {
            
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
            print(songarray[0])
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            sender.isSelected = true
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            selectSongArray.removeAllObjects()
            
            for _ in 0 ..< self.arrayQuranDetail.count {
                self.selectSongArray.add("0")
            }
            self.selectSongArray.replaceObject(at: strindex, with: "1")
            // strindex = strindex + 1
        }
        tblQuranDetail.reloadData()
        
    }
    
    @objc func playerItemDidReachEnd(note: NSNotification) {
        
        selectSongArray.removeAllObjects()
        
        for _ in 0 ..< self.arrayQuranDetail.count {
            self.selectSongArray.add("0")
        }
        
        print(selectSongArray)
        if(strindex < arrayQuranDetail.count-1){
            
            strindex += 1
            print(strindex)
            self.selectSongArray.replaceObject(at: strindex, with: "1")
            print("Video Finished")
            print(strindex)
            print(selectSongArray)
            tblQuranDetail.reloadData()
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
          
            
            if songarray.count > 0 {
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            }
            else {
                let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                     print(dict)
                              
                          CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: (dict["Audio_test"]!), dismissDelay: 3)
            }
            
        }
        else {
            strindex = 0
            self.selectSongArray.replaceObject(at: strindex, with: "1")
            print("Video Finished")
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
            if songarray.count > 0 {
            
            print(songarray[0])
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            player.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
            player.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
            player.currentItem?.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            tblQuranDetail.reloadData()
            }
            else {
                let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                     print(dict)
                              
                          CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: (dict["Audio_test"]!), dismissDelay: 3)
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayerItem {
            switch keyPath {
            case "playbackBufferEmpty":
                print("loader 3")
                break
                
                
            case "playbackLikelyToKeepUp":
                print("loader 2")
                break
                
                
            case "playbackBufferFull":
                print("loader1")
                break
                // Hide loader
                
                
            case .none: break
                
            case .some(_): break
                
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        
        selectSongArray.removeAllObjects()
        
        for _ in 0 ..< self.arrayQuranDetail.count {
            self.selectSongArray.add("0")
        }
        
        if(strindex < arrayQuranDetail.count-1){
            strindex += 1
            print("Video Finished")
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
            if songarray.count > 0 {
            
            print(songarray[0])
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            }
            else {
                let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                     print(dict)
                              
                          CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: (dict["Audio_test"]!), dismissDelay: 3)
            }
        }
        else {
            strindex = 0
            print("Video Finished")
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
            if songarray.count > 0 {
            
            print(songarray[0])
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            }
            else {
                let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                     print(dict)
                              
                          CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: (dict["Audio_test"]!), dismissDelay: 3)
            }
        }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        
        selectSongArray.removeAllObjects()
        
        for _ in 0 ..< self.arrayQuranDetail.count {
            self.selectSongArray.add("0")
        }
        
        if(strindex > 0){
            strindex -= 1
            let diccat = arrayQuranDetail.object(at: strindex) as! JSON
            
            print(diccat)
            
            let songarray = diccat["audioSecondary"].arrayValue
            print(songarray.count)
            
            if songarray.count > 0 {
            
            print(songarray[0])
            
            let songurl = songarray[0].stringValue
            print(songurl)
            
            
            
            // let url = "https://islamic-network.fra1.cdn.digitaloceanspaces.com/quran/audio/192/ar.abdulbasitmurattal/1.mp3"
            let playerItem = AVPlayerItem( url:NSURL( string:songurl)! as URL )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: nil)
            
            player = AVPlayer(playerItem:playerItem)
            player.rate = 1.0;
            
            player.play()
            tblQuranDetail.reloadData()
            }
            else {
                let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                     print(dict)
                              
                          CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: (dict["Audio_test"]!), dismissDelay: 3)
            }
        }
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
