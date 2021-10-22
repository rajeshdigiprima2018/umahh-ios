//
//  ViewController.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(2)
         UserDefaults.standard.set("en.asad", forKey: "quran_lang")
         UserDefaults.standard.set(nil, forKey: "profileload")
        
        if (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
        {
         let callVC = ViewControllerHelper.getViewController(ofType: .home)
           self.navigationController?.pushViewController(callVC, animated: true)

        }
        else {
             UserDefaults.standard.set("", forKey: "access_token")
         UserDefaults.standard.set(nil, forKey: "imageData")
        let callVC = ViewControllerHelper.getViewController(ofType: .IntroVC)
        self.navigationController?.pushViewController(callVC, animated: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
@IBDesignable extension UIView {
    @IBInspectable var cornerRadiusv: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
