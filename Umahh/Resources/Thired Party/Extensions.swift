//
//  Extensions.swift
//  Charged
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Foundation



extension UIColor{
    
    class func appThemeOrangeColor() -> UIColor {
        return UIColor.init(red: 249/255.0, green: 100/255.0, blue: 59/255.0, alpha: 1.0)
    }
    
    class func appButtonLighGrayColor() -> UIColor {
        return UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
    }
    
    class func appDarkGrayTitleColor() -> UIColor {
        return UIColor.init(red: 45/255.0, green: 46/255.0, blue: 47/255.0, alpha: 1.0)
    }
    
    class func appGrayTitleColor() -> UIColor {
        return UIColor.init(red: 96/255.0, green: 97/255.0, blue: 98/255.0, alpha: 1.0)
    }
    
    class func appLighGrayDescriptionColor() -> UIColor {
        return UIColor.init(red: 183/255.0, green: 184/255.0, blue: 185/255.0, alpha: 1.0)
    }
    
    class func appLightGraySperatorColor() -> UIColor {
        return UIColor.init(red: 245/255.0, green: 246/255.0, blue: 247/255.0, alpha: 1.0)
    }
}

extension CGFloat{
    func proportionalFontSize() -> CGFloat
    {
        let sizeToCheckAgainst = self
        let screenHeight = UIScreen.main.bounds.size.height
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if screenHeight==480{
                return (sizeToCheckAgainst - 2.5)
            }else if screenHeight == 568{
                return (sizeToCheckAgainst -  1.5)
            }else if screenHeight == 667{
                return (sizeToCheckAgainst +  0)
            }else if screenHeight == 736{
                return (sizeToCheckAgainst + 1)
            }
            break
        case .pad:
            return (sizeToCheckAgainst + 12)
        default:
            return self
        }
        return self
    }
}

extension UIViewController {
    class func loadTechController() -> Self {
        return instantiateViewControllerFromMainStoryBoard()
    }
    
    fileprivate class func instantiateViewControllerFromMainStoryBoard<T>() -> T
    {
        let controller =  UIStoryboard(name: "Technician", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}

extension UIViewController {
    class func loadUserController() -> Self {
        return instantiateViewControllerFromUserStoryBoard()
    }
    
    fileprivate class func instantiateViewControllerFromUserStoryBoard<T>() -> T
    {
        let controller =  UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}
extension UIViewController {
    class func loadMainController() -> Self {
        return instantiateViewControllerFromCookStoryBoard()
    }
    
    fileprivate class func instantiateViewControllerFromCookStoryBoard<T>() -> T
    {
        let controller =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}
extension CALayer {
    
    
    func addGradientBackground(WithColors color:[UIColor]) -> Void {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: self.bounds.size)
        gradientLayer.colors = color.map({$0.cgColor})
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        self.addSublayer(gradientLayer)
    }
    func addRoundGradientBackground(WithColors color:[UIColor]) -> Void {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = self.bounds.size.width/2
        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: self.bounds.size)
        gradientLayer.colors = color.map({$0.cgColor})
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        
        let roundRect = CALayer()
        roundRect.frame = self.bounds
        roundRect.cornerRadius = self.bounds.size.height/2.0
        roundRect.masksToBounds = true
        roundRect.addSublayer(gradientLayer)
        gradientLayer.mask = roundRect
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.size.height).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.cornerRadius = self.bounds.size.width/2.0
        shapeLayer.strokeColor = UIColor.clear.cgColor
        
        self.addSublayer(shapeLayer)
    }
    
    func addGradientBorder(WithColors color:[UIColor],Width width:CGFloat = 1) -> Void {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
        gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
        gradientLayer.colors = color.map({$0.cgColor})
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.addSublayer(gradientLayer)
    }
    
    //
    //    func addShadow(Color color:UIColor, View view:UIView) -> Void {
    //        //  let shapeLayer = CAShapeLayer()
    //        view.layer.shadowColor = color.cgColor
    //         view.layer.shadowOpacity = 0.3
    //
    //        //self.addSublayer(shapeLayer)
    //    }
    //
    
    func addBorderShadow(Height height:CGFloat, Width width:CGFloat) -> Void {
        
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: width, height: height), cornerRadius: height/2).cgPath
        shapeLayer.fillColor = UIColor.appThemeBlueColor().cgColor
        
        shapeLayer.shadowColor = UIColor .appThemeBlueColor().cgColor
        
        shapeLayer.shadowPath = shapeLayer.path
        shapeLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowRadius = 2
        
        // layer.insertSublayer(shadowLayer, at: 0)
        self.addSublayer(shapeLayer)
    }
}


extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
extension UIColor{
    class func appRedColor() -> UIColor {
        return UIColor.init(red: 226/255.0, green: 71/255.0, blue: 76/255.0, alpha: 1.0)
    }
    class func appThemeBlueColor() -> UIColor {
        return UIColor.init(red:  51/255.0, green: 204/255.0, blue: 219/255.0, alpha: 1.0)
    }
    
    class func appThemeLightBlueColor() -> UIColor {
        return UIColor.init(red:  0/255.0, green: 192/255.0, blue: 73/255.0, alpha: 1.0)
    }
    class func appGrayColor() -> UIColor {
        return UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)
    }
    class func appLightGrayColor() -> UIColor {
        return UIColor.init(red: 179/255.0, green: 179/255.0, blue: 199/255.0, alpha: 1.0)
    }
    class func appLightColor() -> UIColor {
        return UIColor.init(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)
    }
    class func appDarkGrayColor() -> UIColor {
        return UIColor.init(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1.0)
    }
    class func appBorderGrayColor() -> UIColor {
        //return UIColor.init(red: 190/255.0, green: 194/255.0, blue: 205/255.0, alpha: 1.0)
        return UIColor.init(red: 218/255.0, green: 220/255.0, blue: 226/255.0, alpha: 1.0)
    }
    class func appLightBlueColor() -> UIColor {
        return UIColor.init(red: 238/255.0, green: 240/255.0, blue: 248/255.0, alpha: 1.0)
    }
    class func appNotificationSuccess() -> UIColor {
        return UIColor.init(red: 204/255.0, green: 250/255.0, blue: 228/255.0, alpha: 1.0)
    }
    class func appNotificationFail() -> UIColor {
        return UIColor.init(red: 225/255.0, green: 216/255.0, blue: 241/255.0, alpha: 1.0)
    }
    
    class func appPurpleColor() -> UIColor {
        return UIColor.init(red: 103/255.0, green: 57/255.0, blue: 183/255.0, alpha: 1.0)
    }
    class func appGoldenColor() -> UIColor {
        return UIColor.init(red: 247/255.0, green: 188/255.0, blue: 59/255.0, alpha: 1.0)
    }
    class func appPerrotColor() -> UIColor {
        return UIColor.init(red: 0/255.0, green: 148/255.0, blue: 134/255.0, alpha: 1.0)
    }
    class func appGreenColor() -> UIColor {
        return UIColor.init(red: 141/255.0, green: 197/255.0, blue: 62/255.0, alpha: 1.0)
    }
    
    class func appBlackColor() -> UIColor {
        return UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
    }
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
}


extension Int {
    /// returns number of digits in Int number
    public var digitCount: Int {
        get {
            return numberOfDigits(in: self)
        }
    }
    // private recursive method for counting digits
    fileprivate func numberOfDigits(in number: Int) -> Int {
        if abs(number) < 10 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number/10)
        }
    }
}
extension Date{
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    func isGreaterThanOrEqualToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending || self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func isLessThanOrEqualToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending || self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func endOfMonth() -> Date? {
        
        let calendar = NSCalendar.current
        if let plusOneMonthDate = calendar.date(byAdding: .month, value: 1, to: self) {
            
            let plusOneMonthDateComponents = calendar.dateComponents([.month,.year], from: plusOneMonthDate)
            
            let endOfMonth = (calendar.date(from: plusOneMonthDateComponents))?.addingTimeInterval(-1)
            return endOfMonth
        }
        
        return nil
    }
    
    func getDateWith(Seconds second:Int) -> Date {
        var dateComponent = Calendar.current.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: self)
        dateComponent.second = 0
        return Calendar.current.date(from: dateComponent)!
    }
    
    func dateWithTimeFromDate(_ secondDate:Date) -> Date{
        
        let secondDateComponent:DateComponents = NSCalendar.current.dateComponents([.hour,.minute], from: secondDate)
        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
        
        selfDateComponent.hour = secondDateComponent.hour
        selfDateComponent.minute  = secondDateComponent.minute
        
        return NSCalendar.current.date(from: selfDateComponent)!
    }
    
    func dateWith(Hour hour:Int ,AndMinutes minutes:Int) -> Date{
        var selfDateComponent:DateComponents = NSCalendar.current.dateComponents([.day,.month,.year], from: self)
        selfDateComponent.hour = hour
        selfDateComponent.minute  = minutes
        return NSCalendar.current.date(from: selfDateComponent)!
    }
    
    func isToday() -> Bool {
        let dateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
        let currentDateComponents = self.getCurrentDateComponents()
        
        if dateComponents.day == currentDateComponents.day && dateComponents.month == currentDateComponents.month && currentDateComponents.year == dateComponents.year{
            return true
        }else{
            return false
        }
    }
    func getDateInString(withFormat format:String) -> String
    {
        var strConvertedDate:String = ""
        
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        strConvertedDate = dateFormat.string(from: self)
        
        return strConvertedDate
    }
    func convertDateInString(withDateFormat format:String, withConvertedDateFormat convertDate:String) -> String
    {
        var strConvertedDate:String = ""
        
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        strConvertedDate = dateFormat.string(from: self)
        let convertedDate:Date = dateFormat.date(from: strConvertedDate)!;
        dateFormat.dateFormat = convertDate
        strConvertedDate = dateFormat.string(from: convertedDate);
        return strConvertedDate
    }
    func isTimeGretherThanCurrentTime() -> Bool {
        let dateComponents = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: self)
        let currentDateComponents = self.getCurrentDateComponents()
        
        if currentDateComponents.hour! > dateComponents.hour!{
            return true
        }else if currentDateComponents.hour == dateComponents.hour{
            if currentDateComponents.minute! >= dateComponents.minute!{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func getCurrentDateComponents() -> DateComponents {
        return Calendar.current.dateComponents([.day,.month,.year,.hour,.minute], from: Date())
    }
    
    func findNext(DayDate day: String) -> Date {
        
        var calendar = NSCalendar.current
        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        calendar.locale = Locale.current
        
        guard let indexOfDay = calendar.weekdaySymbols.index(of: day) else {
            assertionFailure("Failed to identify day")
            return self
        }
        
        let weekDay = indexOfDay + 1
        
        let components = calendar.component(.weekday, from: self)
        
        if components == weekDay {
            return self
        }
        
        var matchingComponents = DateComponents()
        matchingComponents.weekday = weekDay // Monday
        
        let comingMonday = calendar.nextDate(after: self, matching: matchingComponents, matchingPolicy: Calendar.MatchingPolicy.nextTime)  //calendar.nextDate(After
        
        if let nextDate = comingMonday{
            return nextDate.dateWithTimeFromDate(self)
        }else{
            assertionFailure("Failed to find next day")
            return self
        }
    }
}

extension UIView{
    func addCornerRadiusAndBorder()-> Void{
        self.layer.borderColor = UIColor .appBorderGrayColor().cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
    func addDropShadow() -> Void {
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowColor = UIColor .appThemeBlueColor().cgColor
        self.layer.shadowOpacity = 0.3;
    }
    
    func addGreayDropShadow() -> Void {
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowColor = UIColor .appGrayColor().cgColor
        self.layer.shadowOpacity = 0.3;
    }
    
    func addRoundShadow() -> Void {
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = 7.5;
        self.layer.shadowColor = UIColor .appThemeBlueColor().cgColor
        self.layer.shadowOpacity = 0.5;
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UILabel{
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval) {
        let oldFont = self.font
        self.font = font
        // let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / font.pointSize
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //    self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
    
    func lineSpacingInLabel(Space space:CGFloat, StringText text:String) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = space
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        let attributeText:NSAttributedString =  NSAttributedString(string: text, attributes:attributes)
        // attributedText =
        return attributeText
    }
    
}



extension UIFont{
    
    
    class func appRegularFont(WithSize size:CGFloat) -> UIFont
    {
        return UIFont.init(name: "OpenSans", size: size.proportionalFontSize())!
    }
    class func appSemiboldFont(WithSize size:CGFloat) -> UIFont {
        return UIFont.init(name: "OpenSans-Semibold", size: size.proportionalFontSize())!
        
        //return UIFont.init(name: "Roboto-Medium", size: size.proportionalFontSize())!
    }
    class func appLightFont(WithSize size:CGFloat) -> UIFont {
        return UIFont.init(name: "OpenSans-Light", size: size.proportionalFontSize())!
    }
    class func appBoldFont(WithSize size:CGFloat) -> UIFont {
        return UIFont.init(name: "OpenSans-Bold", size: size.proportionalFontSize())!
    }
    
    class func appSemiBoldItalicFont(WithSize size:CGFloat) -> UIFont {
        return UIFont.init(name: "OpenSans-SemiboldItalic", size: size.proportionalFontSize())!
    }
    
    
}

