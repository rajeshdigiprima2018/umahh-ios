//
//  customLoader.swift
//  Majhool
//
//  Created by Prashant Shinde on 11/27/17.
//  Copyright © 2017 Prashant Shinde. All rights reserved.
//

import Foundation
import UIKit

class customLoader {
    
    static var currentOverlay : UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            
            return
        }
        show(currentMainWindow)
    }
    
    static func show(_ loadingText: String) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            
            return
        }
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static func show(_ overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static func show(_ overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubview(toFront: overlay)
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.center = overlay.center
        indicator.color = UIColor.white   //UIColor.init(red: 95/255, green: 40/255, blue: 226/225, alpha: 1.0)
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        currentOverlay = overlay
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }
}
