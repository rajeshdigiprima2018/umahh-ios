//
//  MosqueMapVC.swift
//  Umahh
//
//  Created by mac on 28/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import GoogleMaps

class MosqueMapVC: UIViewController {
    
     @IBOutlet weak var googleMap: GMSMapView!
     let mosqueLocationMarker = GMSMarker()

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
        
        let latitude:Double = Double(UserDefaults.standard.object(forKey: "mosque_latitude") as! String)!
        
        let longitude:Double = Double(UserDefaults.standard.object(forKey: "mosque_longitude") as! String)!
       
        
      
        
        googleMap?.isMyLocationEnabled = true
        
        
        
        // googleMap.settings.compassButton = true
      //  googleMap.settings.myLocationButton = true
        mosqueLocationMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mosqueLocationMarker.icon = UIImage(named: "mosque_icon")
        mosqueLocationMarker.map = googleMap
        // googleMap.alpha = 0.6
        
        let target = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        googleMap.camera = GMSCameraPosition.camera(withTarget: target, zoom: 15)
//        googleMap.camera = GMSCameraPosition.camera(withLatitude:latitude, longitude: longitude, zoom:18.0)
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
