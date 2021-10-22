//
//  AppHeader.swift
//  Charged
//
//  Created by mac on 07/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


import Foundation






struct Constant{
    struct AppInfo{
        static let Name = "Umahh"
        static let screenSize: CGRect = UIScreen.main.bounds
        static  let baseURL = ""
        
    }
    struct StoryBoardName{
        static let Main = "Main"
        
    }
    struct Endpoint{
        // static  let searchBar = "api/searchBars"
        
    }
    struct INSTAGRAM_IDS {
        
        //static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
        
        
        
    }
    
    
    
    
    struct APIHeader{
        static let DeviceId = "device_id"
        static let AccessToken = "access_token"
        static let DeviceType = "device_type"
        static let UserId = "user_id"
    }
    struct Popup{
        static let Name = "Umahh"
    }
    
    struct AttributedString {
        static let LinkText = "linkText"
        static let LinkUnderline = "shouldAddLinkUnderline"
        static let LinkColor = "linkColor"
        static let LinkFont = "linkFont"
    }
    
    
    struct TextField {
        static var padding = 4.0
        
        static var bottomBorderHeight = 0.5
        static var textFieldText = "textFieldText"
        static var textFieldPlaceholder = "textFieldPlaceholder"
        static var textFieldTextLength = "textFieldTextLength"
        static var textFieldValidationType = "textFieldValidationType"
        static var textFieldKeyboardType = "textFieldKeyboardType"
        static var textFieldEnable = "textFieldEnabled"
        struct ArrowTextField
        {
            static var innerHorizontalPadding = 20.0
            static var innerVerticalPadding = 10.0
            static var headerPlaceHolderName = "headerPlaceHolderName"
            static var firstArrowTextFieldDetails = "firstArrowTextFieldDetails"
            static var secondArrowTextFieldDetails = "secondArrowTextFieldDetails"
            static var arrowType = "arrowType"
        }
        struct TextFieldNotification {
            static var kValueChangeText = "kTextFieldValueChangeText"
            static var kValueDidEndEditing = "kTextFieldDidEndEditing"
        }
    }
    struct TextView
    {
        static var textViewPlaceholder = "textViewPlaceholder"
        static var textViewText = "textViewText"
        static var textViewTextLength = "textViewTextLength"
        
    }
    struct TableView {
        
        static var sectionTitle = "tableViewSectionTitle"
        static var rowHeight = "tableViewRowHeight"
        static var sectionInfoText = "tableViewSectionInfoText"
        static var tableViewCellType = "tableViewCellType"
        /*  struct PromotionDetailContentTableViewCell
         {
         static var kHeaderText = "kHeaderText"
         static var kRatingCount = "kRatingCount"
         static var kDealPrice = "kDealPrice"
         static var kSubHeader = "kSubHeaderText"
         static var kNoteInfo = "kNoteText"
         }*/
        
    }
}

