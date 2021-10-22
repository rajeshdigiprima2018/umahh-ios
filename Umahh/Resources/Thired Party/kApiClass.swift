//
//  kApiClass.swift
//  DriverCity
//
//  Created by Kavin Soni on 28/05/17.
//  Copyright © 2017 Kavin Soni. All rights reserved.
//

import UIKit
import Alamofire
import CRNotifications
//import SwiftLoader


typealias ApiCallSuccessBlock = (Bool,NSDictionary) -> Void
typealias ApiCallFailureBlock = (Bool,NSError?,NSDictionary?) -> Void
typealias APIResponseBlock = ((_ response: NSDictionary?,_ isSuccess: Bool,_ error: Error?)->())

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


enum kAPIType {
    case user_register
    case login
    case loginFB
    case loginGoogle
    case forgetPassword
    case mosquebusiness_register
    case searchmosque
    case selectmosque
    case postsuggestion
    case hajiumrahdetail
    case supplicationdetail
    case businessdetail
    case communitylike
    case communityadd
    case communitydelete
    case bookmarklist
    case addbookmark
    case addfollow
    case followlist
    case categorydonation
    case makepayment
    case mydonationlist
    case uploadimage
    
    
    
    
    
    
    func getEndPoint() -> String {
        switch self {
            // "\(Constant.AppInfo.baseURL)/\(Constant.Endpoint.Subcategory_LIST)/\("4bf58dd8d48988d11e941735")
            
        case .user_register:
            return "user/register"
        case .login:
            return "user/login"
        case .loginFB:
            return "user/loginfb"
        case .loginGoogle:
            return "user/logingoogle"
        case .forgetPassword:
            return "user/password/forgot"
        case .mosquebusiness_register:
            return "mosqueAndbusiness/register"
        case .searchmosque:
            return "mosque/searchMosque"
        case .selectmosque:
            return "mosque/firstSelected/statusChange"
        case .postsuggestion:
            return "mosque/Suggestions/add"
        case .hajiumrahdetail:
            return "hajjumrah/getByhajUmCategory"
        case .supplicationdetail:
            return "supplication/getBySupCategory"
        case .businessdetail:
            return "business/getByCategoryBusinessList"
        case .communitylike:
            return "user/LikeCommunity/add"
        case .communityadd:
            return "user/Community/add"
        case .communitydelete:
            return "user/Community/delete"
        case .bookmarklist:
            return "user/getLikeSupplication"
        case .addbookmark:
            return "user/addLikeSupplication/add"
        case .addfollow:
            return "user/addFollowing"
        case .followlist:
            return "user/getFollowingList/user_id"
        case .categorydonation:
            return "donation/setAmount/getAllByCategoryId"
        case .makepayment:
            return "payment/savePayment"
        case .mydonationlist:
            return "payment/getPaymentByUser"
        case .uploadimage:
            return "user/add/photo"
            
            
            
            
        }
    }
    
    
}







class kApiClass: NSObject {
    
    //MARK:- Singleton
    static let shared = kApiClass()
    
    let baseURL = "http://167.172.131.53:4002/api/"//"http://139.59.83.155:4002/api/"
    
    //let baseURL = "http://lightofweb.com/API/Promove/process.php?action="
    
    
    static var previousAPICallRequestParams:(kAPIType,[String:Any]?)?
    
    static var previousAPICallRequestMultiParams:(kAPIType,[[String:Any]]?)?
    
    
    func callAPI(WithType apiType:kAPIType, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
            /* API URL */
            
            print("------  Parameters --------")
            print(params)
            print("------  Parameters --------")
            
            
            let access_token:String = UserDefaults.standard.object(forKey: "access_token") as! String
            print(access_token)
            
            let token = "\("Bearer")\(access_token)"
            print(token)
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print(apiUrl)
            
            //
            
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization":token]
            print(headers)
            
            
            
            
            Alamofire.request(apiUrl, method: .post, parameters:params, encoding: JSONEncoding.default, headers:headers).responseJSON
                { (response) in
                    print(response)
                    
                    switch response.result{
                        
                    case .success(let json):
                        //SwiftLoader.hide()
                        customLoader.hide()
                        // You got Success :)
                        print(json)
                        //  print("Response Status Code :: \(response.response?.statusCode)")
                        //                        print(json as! NSDictionary)
                        let mainStatusCode:Int = (response.response?.statusCode)!
                        
                        if let jsonResponse = json as? NSDictionary
                        {
                            
                            print(mainStatusCode)
                            print(jsonResponse)
                            
                            //var myBool = true
                            
                            
                            //                            let boolAsString = jsonResponse.value(forKey: "error") as! Bool
                            //                             print(boolAsString)
                            
                            if (mainStatusCode == 200){
                                
                                if ((jsonResponse.value(forKey: "response") as? NSDictionary) != nil){
                                    
                                    let resultDict = jsonResponse.value(forKey: "response") as? NSDictionary
                                    successBlock(resultDict, true, nil)
                                }else{
                                    if jsonResponse.allKeys.count > 0 {
                                        successBlock(jsonResponse, true, nil)
                                    }
                                    
                                }
                            }
                            else if (mainStatusCode == 404){
                                
                                if ((jsonResponse.value(forKey: "response") as? NSDictionary) != nil){
                                    
                                    let resultDict = jsonResponse.value(forKey: "response") as? NSDictionary
                                    successBlock(resultDict, true, nil)
                                }else{
                                    if jsonResponse.allKeys.count > 0 {
                                        successBlock(jsonResponse, true, nil)
                                    }
                                    
                                }
                            }
                            else{
                                customLoader.hide()
                                //                                let boolAsString = jsonResponse.value(forKey: "error") as! Bool
                                //                                print(boolAsString)
                                //                                if (boolAsString){
                                //let errorMessage = jsonResponse.value(forKey: "response") as? String
                                
                                let errorMessage = jsonResponse.value(forKey: "statusCode") as! Int
                                
                                let dict = ["error":errorMessage]
                                
                                CRNotifications.showNotification(type: CRNotifications.error, title: Constant.AppInfo.Name, message: "An internal server error occurred", dismissDelay: 3)
                                
                                //let dict = ["error":errorMessage]
                                successBlock(dict as NSDictionary?, false,nil)
                                //                                }
                                //                            else{
                                //
                                //                                    successBlock(nil, false, nil)
                                //                                }
                                
                            }
                            
                        }else{
                            customLoader.hide()
                            print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                            successBlock(nil, true, nil)
                        }
                        
                        break
                    case .failure(let error):
                        // You Got Failure :(
                        //SwiftLoader.hide()
                        customLoader.hide()
                        print("Response Status Code :: \(String(describing: response.response?.statusCode))")
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                        print(datastring ?? "Test")
                        failureBlock(nil,false,error)
                        break
                    }
            }
        }else{
            let alertController = UIAlertController(title: "Drinker", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
    func callMultiPartAPI(WithType apiType:kAPIType, WithParams params:[String:Any], Success successBlock:@escaping APIResponseBlock, Failure failureBlock:@escaping APIResponseBlock) -> Void
    {
        if Connectivity.isConnectedToInternet() {
            
            let apiUrl:String = "\(self.baseURL)\(apiType.getEndPoint())"
            print(apiUrl)
            //SwiftLoader.show(animated: true)
            //SwiftLoader.show(title: "Loading...", animated: true)
            let access_token:String = UserDefaults.standard.object(forKey: "access_token") as! String
            print(access_token)
            
            let token = "\("Bearer")\(access_token)"
            print(token)
            
            
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization":token]
            print(headers)
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in params {
                    
                    print(key)
                    print(value)
                    
                    
                    if key == "image"
                    {
                        //multipartFormData.append(value as! Data, withName: key)
                        
                        multipartFormData.append(value as! Data, withName: "image", fileName: "profile.jpeg", mimeType: "image/jpeg")
                        
                    }
                        
                    else
                    {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                    
                    
                }
            }, to:apiUrl,headers:headers)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    
                    
                    upload.responseJSON { response in
                        customLoader.hide()
                        //self.delegate?.showSuccessAlert()
                        print(response.request!)  // original URL request
                        print(response.response!) // URL response
                        print(response.data!)     // server data
                        print(response.result)   // result of response serialization
                        //                        self.showSuccesAlert()
                        //self.removeImage("frame", fileExtension: "txt")
                        
                        //SwiftLoader.hide()
                        
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            
                            if let jsonResponse = JSON as? NSDictionary
                            {
                                
                                print(jsonResponse)
                                
                                
                                
                                //                                let code = jsonResponse.value(forKey: "status") as! Int
                                //
                                //                                // let mainStatusCode:Int = (response.response?.statusCode)!
                                //                                print(code)
                                //
                                //                                let stringCode = String(describing: code)
                                //
                                //                                if stringCode  == "1"{
                                
                                if ((jsonResponse.value(forKey: "response") as? NSDictionary) != nil){
                                    
                                    let resultDict = jsonResponse.value(forKey: "response") as? NSDictionary
                                    successBlock(resultDict, true, nil)
                                }else{
                                    if jsonResponse.allKeys.count > 0 {
                                        successBlock(jsonResponse, true, nil)
                                    }
                                    
                                }
                                //                                }else {
                                //                                    //if stringCode  == "1013"{
                                //                                        let errorMessage = jsonResponse.value(forKey: "status") as! Int
                                //
                                //                                        print(errorMessage as AnyObject);
                                //
                                //                                        let dict = ["error":errorMessage]
                                //                                        print(dict);
                                //                                        successBlock(dict as NSDictionary?, false,nil)
                                ////                                    }else{
                                ////
                                ////                                        successBlock(nil, false, nil)
                                //                                    //}
                                //
                                //                                }
                                
                                
                            }else{
                                print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                                successBlock(nil, true, nil)
                            }
                            
                        }
                        
                        
                        /*
                         */
                        
                    }
                    
                case .failure(let encodingError):
                    //self.delegate?.showFailAlert()
                    //SwiftLoader.hide()
                    
                    failureBlock(nil,false,encodingError)
                }
                
            }
            
        }
        else{
            let alertController = UIAlertController(title: "DiverCity", message: "Please check your internet connection", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            
            // let appWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
            // keyWindow.makeKeyAndVisible()
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            //            (alertController, animated: true, completion: nil)
        }
    }
    
}


