//
//  QuiblaVC.swift
//  Umahh
//
//  Created by mac on 12/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class QuiblaVC: UIViewController {
    
     @IBOutlet weak var googleMap: GMSMapView!
     let mosqueLocationMarker = GMSMarker()
    @IBOutlet weak var ivCompassBack: UIImageView!
    @IBOutlet weak var ivCompassNeedle: UIImageView!
    var compassManager  : CompassDirectionManager!
   
//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var angleLabel: UILabel!
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    var yourLocationBearing: CGFloat { return latestLocation?.bearingToLocationRadian(self.yourLocation) ?? 0 }
    var yourLocation: CLLocation {
        get { return UserDefaults.standard.currentLocation }
        set { UserDefaults.standard.currentLocation = newValue }
    }
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = locationDelegate
        var qiblaAngle : CGFloat = 0.0
        compassManager =  CompassDirectionManager(dialerImageView: ivCompassBack, pointerImageView: ivCompassNeedle)
        compassManager.initManager()
//        locationDelegate.errorCallback = { error in
//           // self.angleLabel.text = error
//            self.imageView.isHidden = true
//            print(error)
//        }
        
//        locationDelegate.locationCallback = { location in
//            self.latestLocation = location
//
//            let phiK = 21.4*CGFloat.pi/180.0
//            let lambdaK = 39.8*CGFloat.pi/180.0
//            let phi = CGFloat(location.coordinate.latitude) * CGFloat.pi/180.0
//            let lambda =  CGFloat(location.coordinate.longitude) * CGFloat.pi/180.0
//            qiblaAngle = 180.0/CGFloat.pi * atan2(sin(lambdaK-lambda),cos(phi)*tan(phiK)-sin(phi)*cos(lambdaK-lambda))
//           // self.angleLabel.text = "\(Int(qiblaAngle.rounded()))°"
//
//            self.imageView.isHidden = false
//        }
        
//        locationDelegate.headingCallback = { newHeading in
//            
//            func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
//                let heading = self.yourLocationBearing - newAngle.degreesToRadians
//                return CGFloat(heading)
//            }
//            
//            UIView.animate(withDuration: 0.5) {
//                let angle = (CGFloat.pi/180 * -(CGFloat(newHeading) - qiblaAngle))
//                self.imageView.transform = CGAffineTransform(rotationAngle: angle)
//            }
//        }

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
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Qiblah"]!))
        
        let latitude = 21.422487
        
        let longitude = 39.826206
        //21.422487, 39.826206
        
        
        
        googleMap?.isMyLocationEnabled = true
        
        
        
        googleMap.camera = GMSCameraPosition.camera(withLatitude:latitude, longitude:longitude, zoom:1.0)
        // googleMap.settings.compassButton = true
        //  googleMap.settings.myLocationButton = true
        mosqueLocationMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        mosqueLocationMarker.icon = UIImage(named: "mosque_icon")
        
        mosqueLocationMarker.map = googleMap
        
        
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
