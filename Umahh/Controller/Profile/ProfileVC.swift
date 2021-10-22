//
//  ProfileVC.swift
//  Umahh
//
//  Created by mac on 28/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CRNotifications

class ProfileVC: UIViewController {
    
     @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    var imagePicker = UIImagePickerController()
    var imageData:Data = Data()
     var imageContent:Data = Data()
    
     @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnFeed: UIButton!
    @IBOutlet weak var btnDonation: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
         appDelegate.setRoundRectAndBorderColor(view: viewMain, color: UIColor.clear, width: 0.0, radious: 5.0)

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
        let email:String = UserDefaults.standard.object(forKey: "email") as! String
         let nameContactPerson:String = UserDefaults.standard.object(forKey: "nameContactPerson") as! String
        // let imgurl:String = UserDefaults.standard.object(forKey: "avtar") as! String
        
        lblname.text = nameContactPerson
        lblEmail.text = email
        
        if (UserDefaults.standard.object(forKey: "imageData") != nil)
        {
        
        let uiImage: UIImage  =  UIImage(data: UserDefaults.standard.data(forKey: "imageData")!) ?? UIImage(named: "Layer 1")!
        self.imguser.image = uiImage
           
            self.imguser.layer.cornerRadius = self.imguser.frame.size.width/2
            self.imguser.clipsToBounds = true
        
        }
       
        
         let dict:Dictionary = UserDefaults.standard.object(forKey: "dict") as! Dictionary <String, String>
                                                print(dict)
        
        btnHome.setTitle((dict["My_Home_Mosque"]!), for: .normal)
        btnFollowing.setTitle((dict["Follw_mosque"]!), for: .normal)
        btnSettings.setTitle((dict["Settings"]!), for: .normal)
        btnFeed.setTitle((dict["Today_Feed"]!), for: .normal)
        btnDonation.setTitle((dict["My_Donation"]!), for: .normal)
        appDelegate.setNavigationBarStyleWithTransparent(navigationController: navigationController!, viewController: self, title: (dict["Profile"]!))
        
        
       
    }
    
    @IBAction func followclick(_ sender: Any) {
        
        let callVC = ViewControllerHelper.getViewController(ofType: .followVC)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    
    @IBAction func mosqueclick(_ sender: Any) {
         UserDefaults.standard.set("profile", forKey: "profileload")
        let callVC = ViewControllerHelper.getViewController(ofType: .selectmosque)
        self.navigationController?.pushViewController(callVC, animated: true)
       
    }
    
    @IBAction func settingclick(_ sender: Any) {
        
        let callVC = ViewControllerHelper.getViewController(ofType: .settings)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @IBAction func feedclick(_ sender: Any) {
        
        let callVC = ViewControllerHelper.getViewController(ofType: .feed)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(callVC, animated: true)
    }
    @IBAction func mydonationclick(_ sender: Any) {
        
        let myViewController = MyDonationVC(nibName: "MyDonationVC", bundle: nil)
        self.navigationController?.pushViewController(myViewController, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pickerClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ProfileVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imguser.image = editedImage
            imageData = (UIImageJPEGRepresentation(editedImage , 0.1)!)
            UserDefaults.standard.set(imageData, forKey: "imageData")
            imageContent = (UIImageJPEGRepresentation(editedImage , 0.1)!)
            UserDefaults.standard.set(imageContent, forKey: "imageData")
            
            
            
        }
        else {
            self.imguser.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            imageData = (UIImageJPEGRepresentation(originalImage! , 0.1)!)
            UserDefaults.standard.set(imageData, forKey: "imageData")
            
            
            
        }
        
       
        self.imguser.layer.cornerRadius = self.imguser.frame.size.width/2
        self.imguser.clipsToBounds = true
        
        
        //btnAddimage.isHidden = true
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
        
        self.updateprofileimage()
    }
    
    func updateprofileimage(){
        kApiClass .shared .callMultiPartAPI(WithType: .uploadimage, WithParams: [
        "image":imageData,
        ], Success: { (response, isSuccess, error) in
      customLoader.show()
                if isSuccess == true
                {
                    print("yes");

                    print(response as AnyObject)
                    //let data = response?.value(forKey: "message")as! NSDictionary

                   // let getcode = response?.value(forKey: "code")as! Int
                      customLoader.hide()




                   }
         


        }, Failure:{_,_,_ in
            CRNotifications.showNotification(type: CRNotifications.error, title: Constant.Popup.Name, message: "Network Error", dismissDelay: 3)
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }

}
