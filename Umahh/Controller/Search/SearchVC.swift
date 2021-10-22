import UIKit
import CoreLocation
import CRNotifications
import Alamofire
import SwiftyJSON
import GoogleMaps

class SearchVC: UIViewController,MapMarkerDDelegate,DrawerTransitionDelegate,SideMenuDelegae,UISearchBarDelegate {
    
    @IBOutlet weak var googleMap: GMSMapView!
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    private var infoWindow = MarkerDInfoView()
    var markersArray: Array<GMSMarker> = []
    
    @IBOutlet weak var searchview: UISearchBar!
    let geocoder = CLGeocoder()
    
    var arrayMosque = NSArray();
    
    private var leftMenu  = SideMenuViewController()
    private var leftDrawerTransition:DrawerTransition!
    
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblBookmark: UILabel!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var lblDonation: UILabel!
    @IBOutlet weak var lblSettings: UILabel!
    
    @IBOutlet weak var btnAll: UIButton!
    
    @IBOutlet weak var btnViewMore: UIButton!
    
    @IBOutlet weak var viewMosqueInfo: UIView!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var imgmosque: UIImageView!
    @IBOutlet weak var lblMosquename: UILabel!
    @IBOutlet weak var lblMosqueinfo: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var dict = NSDictionary()
    
    var strMosqueid = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoWindow = loadNiB()
        
        dict = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String> as NSDictionary
        print(dict)
        searchview.delegate = self

        
        
        btnAll.setTitle(dict["All"]! as! String, for: .normal)
        
        lblHome.text = (dict["Home"]! as! String)
        lblBookmark.text = (dict["Bookmark"]! as! String)
        lblSearch.text = (dict["Search"]! as! String)
        lblDonation.text = (dict["Donation"]! as! String)
        lblSettings.text = (dict["Settings"]! as! String)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        leftMenu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        
        //leftMenu = self.storyboard?.instantiateViewController(withIdentifier:"SideMenuViewController") as! SideMenuViewController
        leftMenu.delegate = self
        self.leftDrawerTransition = DrawerTransition(target: self, drawer: leftMenu)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left
        
        
        // Do any additional setup after loading the view.
    }
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text!.count>0{
            googleMap.clear()
            self.searchview.endEditing(true)
        self.mosquelistApiSearch(text: searchBar.text!)
        }
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
                return true
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {


    }
    
    
    
    @IBAction func menuBtnClicked(sender: UIButton)
    {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        appDelegate.setRoundRectAndBorderColor(view: btnViewMore, color: UIColor.clear, width: 0.0, radious: 5.0)
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setViews()
        self.mosquelistApi()
        
        
        
    }
    
    
    
    func setViews()
    {
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
        
        let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
        googleMap.delegate = self
        
        googleMap?.isMyLocationEnabled = true
        
        
        
        googleMap.camera = GMSCameraPosition.camera(withLatitude:Double(latitude)!, longitude: Double(longitude)!, zoom:0.0)
        googleMap.settings.compassButton = true
        googleMap.settings.myLocationButton = true
        // googleMap.alpha = 0.6
    }
    
    @IBAction func mosquelistClicked(_ sender: Any) {
        //  let callVC = ViewControllerHelper.getViewController(ofType: .mosqueListNearby)
        // self.navigationController?.pushViewController(callVC, animated: true)
        
        let myViewController = AllMosqueListVC(nibName: "AllMosqueListVC", bundle: nil)
        self.navigationController?.pushViewController(myViewController, animated: true)
        
    }
    
    func mosquelistApi(){
        customLoader.show()
        
        let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
        
        let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
        
        // let urlPath = "http://139.59.83.155:4002/api/user/getStates/1"
        
        let urlPath =  "http://167.172.131.53:4002/api/mosque/nearby/\(latitude)/\(longitude)/\("99999")"
        print(urlPath)
        
        
        Alamofire.request(urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayMosque = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayMosque);
                
                print(self.arrayMosque);
                for i in 0..<self.arrayMosque.count {
                    let diccat = self.arrayMosque.object(at: i) as! JSON
                    print(diccat)
                    
                    
                    let getlat = diccat["lat"]
                    
                    let getlong = diccat["lng"]
                    
                    let stationData : NSDictionary = [
                        "mosque_name": diccat["username"].string!,
                        "lat": diccat["lat"],
                        "long": diccat["lng"],
                        "descrption": diccat["street_address"].stringValue,
                        "mosque_id": diccat["_id"].stringValue,
                        "mosque_img": diccat["avtar"].stringValue
                    ]
                    ////////////////DevD
                    //  self.googleMap.camera = GMSCameraPosition.camera(withLatitude:getlat.doubleValue, longitude: getlong.doubleValue, zoom:19.0)
                    
                    let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
                    
                    let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
                    self.googleMap.camera = GMSCameraPosition.camera(withLatitude:Double(latitude)!, longitude: Double(longitude)!, zoom:8.0)
                    
                    let imageView = UIImageView(image: UIImage(named: "mosque_icon")!)
                    
                    let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
                    print(avtar)
                    
                    imageView.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_icon")!)
                    appDelegate.setRoundRectAndBorderColor(view: imageView, color: UIColor.clear, width: 0.0, radious: imageView.frame.size.height/2)
                    
                    // let markerView = UIImageView(image: UIImage(named: "pin")!)
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: getlat.doubleValue, longitude: getlong.doubleValue)
                    //marker.title = diccat["name"].string
                    marker.userData = stationData
                    //marker.snippet = "\("Male ")\(getMaleCount)\("%    ")\("  Female ")\(getfemaleCount)\("%")"
                    marker.iconView = imageView
                    marker.map = self.googleMap
                    
                }
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    func mosquelistApiSearch(text: String){
        customLoader.show()
          
        let urlPath =  "http://167.172.131.53:4002/api/mosque/searchMosque"
        print(urlPath)
        
        Alamofire.request(urlPath, method: .post, parameters: ["searchmosque": text], encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                self.arrayMosque = swiftyJsonVar["data"].arrayValue as NSArray
                print(self.arrayMosque);
                
                print(self.arrayMosque);
                for i in 0..<self.arrayMosque.count {
                    let diccat = self.arrayMosque.object(at: i) as! JSON
                    print(diccat)
                    
                    
                    let getlat = diccat["lat"]
                    
                    let getlong = diccat["lng"]
                    
                    let stationData : NSDictionary = [
                        "mosque_name": diccat["username"].string!,
                        "lat": diccat["lat"],
                        "long": diccat["lng"],
                        "descrption": diccat["street_address"].stringValue,
                        "mosque_id": diccat["_id"].stringValue,
                        "mosque_img": diccat["avtar"].stringValue
                    ]
                    ////////////////DevD
                    //  self.googleMap.camera = GMSCameraPosition.camera(withLatitude:getlat.doubleValue, longitude: getlong.doubleValue, zoom:19.0)
                    
//                    let latitude:String = UserDefaults.standard.object(forKey: "current_latitude") as! String
//
//                    let longitude:String = UserDefaults.standard.object(forKey: "current_longitude") as! String
//                    self.googleMap.camera = GMSCameraPosition.camera(withLatitude:Double(latitude)!, longitude: Double(longitude)!, zoom:8.0)
                    
                    let imageView = UIImageView(image: UIImage(named: "mosque_icon")!)
                    
                    let avtar : String =  "http://167.172.131.53:4002\(diccat["avtar"].stringValue)"
                    print(avtar)
                    
                    imageView.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_icon")!)
                    appDelegate.setRoundRectAndBorderColor(view: imageView, color: UIColor.clear, width: 0.0, radious: imageView.frame.size.height/2)
                    
                    // let markerView = UIImageView(image: UIImage(named: "pin")!)
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: getlat.doubleValue, longitude: getlong.doubleValue)
                    //marker.title = diccat["name"].string
                    marker.userData = stationData
                    //marker.snippet = "\("Male ")\(getMaleCount)\("%    ")\("  Female ")\(getfemaleCount)\("%")"
                    marker.iconView = imageView
                    marker.map = self.googleMap
                    
                    
                    self.googleMap.camera = GMSCameraPosition.camera(withLatitude:getlat.doubleValue, longitude: getlong.doubleValue, zoom:8.0)
                  
                }
                
                customLoader.hide()
                
                break
            case .failure:
                customLoader.hide()
                print(Error.self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        
        print(coordinate.latitude)
        print(coordinate.longitude)
        
        
        // self.MapDataApi()
        
        
        
    }
    
}
extension SearchVC: GMSMapViewDelegate {
    internal func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    internal func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        //addressLabel.lock()
        
        if (gesture) {
            // mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
        }
    }
    func loadNiB() -> MarkerDInfoView {
        let infoWindow = MarkerDInfoView.instanceFromNib() as! MarkerDInfoView
        return infoWindow
    }
    
    func didTapDInfoButton(data: NSDictionary)
    {
        print(data)
        
        UserDefaults.standard.set(data["mosque_id"], forKey: "sel_mosque_id")
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = data["mosque_id"] as! String
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                print("locationMarker is nil")
                return
            }
            infoWindow.center = mapView.projection.point(for: location)
            infoWindow.center.y = infoWindow.center.y + 45
            if infoWindow.frame.origin.y < 164
            {
                infoWindow.removeFromSuperview()
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        // infoWindow.removeFromSuperview()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // mapCenterPinImage.fadeOut(0.25)
        var markerData : NSDictionary?
        if marker.userData == nil
        {
            return true
        }
        if let data = marker.userData! as? NSDictionary {
            markerData = data
        }
        locationMarker = marker
        infoWindow.removeFromSuperview()
        infoWindow = loadNiB()
        guard let location = locationMarker?.position else {
            print("locationMarker is nil")
            return false
        }
        // Pass the spot data to the info window, and set its delegate to self
        infoWindow.spotData = markerData
        infoWindow.delegate = self
        // Configure UI properties of info window
        infoWindow.alpha = 1.0
        infoWindow.layer.cornerRadius = 2
        infoWindow.layer.borderWidth = 2
        infoWindow.layer.borderColor = UIColor.white.cgColor
        
        print(markerData!)
        
        let mosqueName = markerData!["mosque_name"]!
        let description = markerData!["descrption"]!
        let mosque_img = markerData!["mosque_img"]!
        strMosqueid = markerData!["mosque_id"]! as! NSString
        let lat = markerData!["lat"]!
        let long = markerData!["long"]!
        
        viewMosqueInfo.isHidden = false
        
        lblMosquename.text = mosqueName as? String
        lblMosqueinfo.text = description as? String
        
        let avtar : String =  "http://167.172.131.53:4002\(mosque_img)"
        print(avtar)
        
        imgmosque.sd_setImage(with: URL(string: avtar), placeholderImage: UIImage(named: "mosque_icon")!)
        appDelegate.setRoundRectAndBorderColor(view: imgmosque, color: UIColor.clear, width: 0.0, radious: imgmosque.frame.size.height/2)
        
        
        
        //        infoWindow.stationName.text = "\(mosqueName)"
        //        infoWindow.descriptionname.text = "\(description)"
        //
        //        infoWindow.center = mapView.projection.point(for: location)
        //        infoWindow.center.y = infoWindow.center.y + 105
        //        self.view.addSubview(infoWindow)
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        // mapCenterPinImage.fa(0.25)
        mapView.selectedMarker = nil
        return false
    }
    
    @IBAction func viewmoreClicked(_ sender: Any) {
        UserDefaults.standard.set(strMosqueid, forKey: "sel_mosque_id")
        let callVC:MosqueDetailVC = ViewControllerHelper.getViewController(ofType: .mosquedetail) as! MosqueDetailVC
        callVC.mosqueid = strMosqueid as String
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    // Tab bar class
    
    @IBAction func homeClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .home)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func bookmarkClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            let callVC = ViewControllerHelper.getViewController(ofType: .Bookmark)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(callVC, animated: false)
        }
        else {
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
        
        
    }
    @IBAction func searchClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .Search)
        self.navigationController?.pushViewController(callVC, animated: false)
        
        
    }
    @IBAction func donationClicked(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
            
            let myViewController = NewMosqueList(nibName: "NewMosqueList", bundle: nil)
            self.navigationController?.pushViewController(myViewController, animated: true)
        }
        else {
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Please login on app", dismissDelay: 3)
        }
        
        
    }
    
    func CommonfunctionForSideMenuDelegate(text:String)
    {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if text == "Login" {
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
        }
        else if text == "profile"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .ProfileVc)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
        }
        else if text == "Bookmark"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Bookmark)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Donation"{
            DispatchQueue.main.async { [self] in
                // let callVC = ViewControllerHelper.getViewController(ofType: .donation)
                let callVC:DonateVC  = ViewControllerHelper.getViewController(ofType: .donation) as! DonateVC
                callVC.mosqueid =  self.strMosqueid as String
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Prefs"{
            DispatchQueue.main.async {
                //                let callVC = ViewControllerHelper.getViewController(ofType: .pre)
                //
                //                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Today's Feed"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .feed)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Quran"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Quranlist)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Community"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .CommunityList)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Settings"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .settings)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Qiblah"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Qiblah)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Quize"{
            DispatchQueue.main.async {
                
            }
            
        }
        else if text == "Personnage"{
            DispatchQueue.main.async {
                
            }
            
        }
        else if text == "Zakkat Calculator"{
            DispatchQueue.main.async {
                
            }
            
        }
        else if text == "Haji"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Hajiumrah)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Supplication"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Supplication)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Business"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .business)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
        else if text == "Organization"{
            DispatchQueue.main.async {
                let callVC = ViewControllerHelper.getViewController(ofType: .Organization)
                
                self.navigationController?.pushViewController(callVC, animated: true)
            }
            
        }
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        let callVC = ViewControllerHelper.getViewController(ofType: .settings)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    
    @IBAction func showfilter(sender: AnyObject) {
        let alert = UIAlertController(title: (dict["Ummah"]! as! String), message: (dict["Please_option"]! as! String), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: (dict["All"]! as! String), style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            self.mosquelistApi()
        }))
        
        alert.addAction(UIAlertAction(title: (dict["mosque"]! as! String), style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            self.mosquelistApi()
        }))
        
        //        alert.addAction(UIAlertAction(title: (dict["Business_organization"]! as! String), style: .destructive , handler:{ (UIAlertAction)in
        //            print("User click Delete button")
        //             self.mosquelistApi()
        //        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}
