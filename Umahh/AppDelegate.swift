//
//  AppDelegate.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import GoogleMaps
import Braintree
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import GoogleSignIn



let googleApiKey = "AIzaSyDNmotgwqC8ITkS7VcXB0c5itpF6oVQfS4"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
     let locationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
         BTAppSwitch.setReturnURLScheme("com.digiprima.ummah.payments")
        
        GMSServices.provideAPIKey(googleApiKey)
     // GMSServices.provideAPIKey("AIzaSyBQMdFckT8Z7pxqt5Ux66SgG3nZPoPR1ag")
        GIDSignIn.sharedInstance().clientID = "889637771668-tuaqst2f3ih4gvun751veo98gt4jnf72.apps.googleusercontent.com"
        
        //IQKeyboardManager.shared.enable = true
         IQKeyboardManager.sharedManager().enable = true
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Override point for customization after application launch.
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
           Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
        }
         
        application.registerForRemoteNotifications()
         
        FirebaseApp.configure()
        
        return true
    }
    
   func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            print(token)
            //let usersRef = Firestore.firestore().collection("users_table").document(userID)
           // usersRef.setData(["fcmToken": token], merge: true)
        }
    }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        if let refreshedToken = InstanceID.instanceID().token(withAuthorizedEntity: <#String#>, scope: <#String#>, handler: <#InstanceIDTokenHandler#>) {
//            print("InstanceID token: \(refreshedToken)")
//        }
//    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                  UserDefaults.standard.set(result.token, forKey: "token")
            }
        })
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) ///\(locValue.longitude)")
        
        UserDefaults.standard.set("\(locValue.latitude)", forKey: "current_latitude")
        UserDefaults.standard.set("\(locValue.longitude)", forKey: "current_longitude")
        UserDefaults.standard.synchronize()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error")
        
        UserDefaults.standard.set("22.6941829330965", forKey: "current_latitude")
        UserDefaults.standard.set("75.9295288670566", forKey: "current_longitude")
        UserDefaults.standard.synchronize()
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Ishant Functions:
    //MARK: CHANGE PLACEHOLDER COLOR TEXTFIELD
    func changePlaceholderTextColor(textFiled: UITextField, textString:String, color:UIColor)
    {
        textFiled.attributedPlaceholder = NSAttributedString(string: textString, attributes: [NSAttributedStringKey.foregroundColor: color])
        textFiled.tintColor = color
    }
    func setRoundRectAndBorderColor(view: UIView, color:UIColor, width:CGFloat, radious: CGFloat)
    {
        view.clipsToBounds = true
        view.layer.cornerRadius = radious
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
    }
    
    //MARK: ADD SPACING IN TEXTFILED
    func addLeadingSpacingInTextField(textFiled:UITextField)
    {
        let leftView = UILabel(frame: CGRect(x: 10, y: 0, width: 20, height: 45))
        leftView.backgroundColor = .clear
        textFiled.leftView = leftView
        textFiled.leftViewMode = .always
        textFiled.contentVerticalAlignment = .center
    }
    
    //MARK: SET NAVIGATION BAR STYLE
    func setNavigationBarStyle(navigationController:UINavigationController, viewController:UIViewController, title:String)
    {
        navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController.navigationBar.barTintColor = UIColor.clear
        navigationController.navigationBar.tintColor = UIColor.white
        //navigationController.navigationBar.setBackgroundImage(UIImage(named: "back"), for: .default)
 navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        viewController.title = title
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    func setNavigationBarStyleWithTransparent(navigationController:UINavigationController, viewController:UIViewController, title:String)
    {
        navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController.navigationBar.barTintColor = UIColor.clear
        navigationController.navigationBar.tintColor = UIColor.white
        //navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Medium", size: 17)!]
        let image = UIImage(named: "back_key")
        
        navigationController.navigationBar.backIndicatorImage = image
        navigationController.navigationBar.backIndicatorTransitionMaskImage = image
        
         navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        viewController.title = title
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
           if url.scheme?.localizedCaseInsensitiveCompare("com.digiprima.ummah.payments") == .orderedSame {
               return BTAppSwitch.handleOpen(url, options: options)
           }
           return false
       }

       // If you support iOS 8, add the following method.
       func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
           if url.scheme?.localizedCaseInsensitiveCompare("com.digiprima.ummah.payments") == .orderedSame {
               return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication)
           }
           return false
       }


}

