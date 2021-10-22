//
//  Utility.swift
//  CherishGold
//
//  Created by Leo on 10/10/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit
import SystemConfiguration

let HT = UIScreen.main.bounds.size.height
let WD = UIScreen.main.bounds.size.width


class Utility: NSObject {

    //    class func isInternetConnected() -> Bool
    //    {
    //
    //        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    //        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    //        zeroAddress.sin_family = sa_family_t(AF_INET)
    //
    //        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
    //            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
    //                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
    //            }
    //        }
    //
    //        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    //        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
    //            return false
    //        }
    //
    //        let isReachable = flags == .reachable
    //        let needsConnection = flags == .connectionRequired
    //
    //        return isReachable && !needsConnection
    //
    //    }

    class func isInternetConnected(isShowPopup: Bool) -> Bool
    {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
        {
            if isShowPopup
            {
                showAlertController(stringTitle: "", stringMessage: "Please check your internet connection")
            }
            return false
        }

        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        if isReachable == false
        {
            if isShowPopup
            {
                showAlertController(stringTitle: "", stringMessage: "Please check your internet connection")
            }
        }

        return isReachable && !needsConnection

    }


    class func setKey(_ stringKey: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.set(stringKey, forKey: "key")
        userDefaults.synchronize()
    }


    class func getKey() -> String
    {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "key")! as! String
    }


    class func addShadowBelowView(viewTemp: UIView)
    {
        viewTemp.layer.shadowColor = UIColor.gray.cgColor
        viewTemp.layer.shadowOpacity = 5
        viewTemp.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewTemp.layer.shadowRadius = 5
        viewTemp.layer.shouldRasterize = false

    }


    class func showAlertController(stringTitle: String, stringMessage: String)
    {
        var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController

        while ((topController.presentedViewController) != nil)
        {
            topController = topController.presentedViewController!;
        }

        let alert = UIAlertController(title: stringTitle, message: stringMessage, preferredStyle: UIAlertControllerStyle.alert)
        //        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))

        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            //Just dismiss the action sheet
            print("OK")
        }
        alert.addAction(okAction)

        topController.present(alert, animated:true, completion:nil)
    }


    class func drawBorderWithLightGrayColor(view: UIView, cornerRadius: CGFloat, borderWidth: CGFloat)
    {
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = UIColor.lightGray.cgColor
    }


    //    class func makeACallWithAlert(isShowAlert: Bool, PhoneNumber stringPhoneNumber: String)
    //    {
    //
    //        var stringPhoneNumberTemp = (stringPhoneNumber.componentsSeparatedByCharactersInSet<AnyObject>(NSCharacterSet(charactersInString: "+0123456789").invertedSet) as NSArray).componentsJoinedByString("")
    //        print("Call")
    //        stringPhoneNumberTemp = "tel://".stringByAppendingString(stringPhoneNumberTemp)
    //        UIApplication.sharedApplication().openURL(NSURL(string: stringPhoneNumberTemp)!)
    //    }

    class func makeACall(phoneNumber:String)
    {
        // "telprompt://"
        // "tel://\(123456789)"

        guard let number = URL(string: "telprompt://" + phoneNumber) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    
}
