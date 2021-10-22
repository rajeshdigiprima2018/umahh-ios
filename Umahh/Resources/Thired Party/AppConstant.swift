//
//  AppConstant.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

//CurrentDevice constants
struct CurrentDevice {
    static let isiPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    static let iPhone4S = isiPhone && UIScreen.main.bounds.size.height == 480
    static let iPhone5    = isiPhone && UIScreen.main.bounds.size.height == 568.0
    static let iPhone6    = isiPhone && UIScreen.main.bounds.size.height == 667.0
    static let iPhone6P = isiPhone && UIScreen.main.bounds.size.height == 736.0
    static let iPhoneX  = isiPhone && UIScreen.main.bounds.size.height == 812.0
}

//App level common constants
struct AppConstants {
    static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
    static let PORTRAIT_SCREEN_WIDTH  = UIScreen.main.bounds.size.width
    static let PORTRAIT_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let CURRENT_IOS_VERSION = UIDevice.current.systemVersion
    // static let errSomethingWentWrong  = NSError(domain: //AlertMessages.ALERT_SOMETHING_WENT_WRONG, code: 0, userInfo: nil)
}

struct Strings{
    static let NO_IMAGES_AVAILABLE    = "Tap the camera above to start capturing moments from your favorite places."
    static let NO_DATA_AVAILABLE    = "No results found."
    static let NO_DATA_AVAILABLE_FOR_FAVORITE    = "To add a favorite, tap the heart on any bar/restaurant profile."
    static let NO_PROMOTION_AVAILABLE    = "No promotions found."
    static let NO_ORDER_AVAILABLE    = "No orders found."
    static let NO_PROMOTION_BUSINESS_AVAILABLE    = "Promotion analytics will show here when they go live"
    static let FINDING_YOUR_LOCATION    = "Finding your location"
    static let FETCHING_RESTAURANTS    = "" // Fetching restaurants
    static let MOMENTS_SUBTITLE_MESSAGE = "View past moments at this location from the Instagram community."
    static let REVIEW_SUBTITLE_MESSAGE = "View feedback from the Foursquare & Yelp community."
    static let RESERVATION_SUBTITLE_MESSAGE = "Make reservations via Opentable."
    static let FEATURED_SUBTITLE_MESSAGE = "Events, specials and suggested items."
    static let EMPTY_CUSTOM_ORDER = "Please type your order then tap submit."
    static let MARTINIS = "Martinis"
    static let LIQUORSPIRITS = "Liquor/Spirits"
}

//Nib,XIB names
struct NibNames{
    
    
    static let NIB_LOGINVC                        = "LoginVC"
    static let NIB_INTROVC                        = "IntroVC"
    static let NIB_Signupvc                       = "SignupVC"
    static let NIB_ChangePassword                 = "ChangePassword"
    static let NIB_AccountType                    = "AccountTypeVC"
    static let NIB_Verification                   = "VerificationVC"
    static let NIB_ForgetPassword                 = "ForgetVc"
    static let NIB_OwnerAccount                  = "BusinessOwnerSignupVC"
    static let NIB_MosqueAccount                  = "MosqueSignVC"
    static let NIB_selectmosque                  = "SelectMosqueVC"
     static let NIB_home                         = "HomeVC"
    static let NIB_mosquedetail                  = "MosqueDetailVC"
    static let NIB_board                         = "BaordVC"
    static let NIB_khutba                         = "KhutbaVC"
    static let NIB_payment                       = "PaymentVC"
    static let NIB_EduList                       = "EducationListVC"
    static let NIB_Suggestion                    = "SuggestionVC"
     static let NIB_ActiList                     = "ActivityList"
    static let NIB_ActiListDetail                = "ActivityDetail"
    static let NIB_NewsList                     = "NewsList"
    static let NIB_Associates                    = "AssociationList"
    static let NIB_Calendor                    = "CalendorVC"
    static let NIB_Donate                    = "DonateVC"
    //ActivityDetail
    //..................//
    
    static let NIB_Feed                      = "FeedVc"
     static let NIB_Quran                    = "QuranListVC"
     static let NIB_Community                = "CommunityListVC"
     static let NIB_Settings                 = "SettingsVC"
     static let NIB_Qiblah                   = "QuiblaVC"
     static let NIB_Quiz                     = "QuizList"
     static let NIB_Personnage               = "PersonangeVC"
     static let NIB_Zakat_calc               = "ZakatCalcVC"
     static let NIB_Hajiumrah                = "HajiUmrahVC"
     static let NIB_Supplication             = "SupplicationVC"
     static let NIB_Business                 = "BusinessVC"
     static let NIB_Organization             = "OrganizationVC"
     static let NIB_BookmarkVC               = "BookmarkVC"
     static let NIB_Search                   = "SearchVC"
     static let NIB_mosquelist               = "MosqueListVC"
     static let NIB_prayertime               = "PrayerTimeVC"
     static let NIB_HajiumrahVC              = "HajiListVC"
     static let NIB_SuplicationDetail        = "SupplicationDetailVC"
    static let NIB_BusinessDetail        = "BusinessDetailVC"
    static let NIB_NewsDetail        = "NewsDetail"
    static let NIB_AddCommunity        = "AddNewRequest"
     static let NIB_umrahcontentdetail       = "UmrahListVC"
    static let NIB_edudetail       = "EducationDetailVC"
     static let NIB_mosqueMap       = "MosqueMapVC"
    static let NIB_profilevc       = "ProfileVC"
     static let NIB_businessdetailfinal       = "BusinessDetailFinalVC"
    static let NIB_mosquelistVC       = "MosquelistVC"
    static let NIB_specialdonate       = "FirstDonationVC"
    static let NIB_qurandetail       = "QuranDetailVC"
     static let NIB_followvc       = "FollowVC"
    
    
    //
    
    
    //    static let CELL_ID_USER_FEED_MAP_CELL                  = "UserFeedMapCell"
    
}
//cell identifiers
struct CellIds{
    static let CELL_ID_BUSINESS_PROMOTIONS_LISTING         = "BusinessPromotionsListingCell"
    static let CELL_ID_USER_FEED_CELL                      = "UserFeedCell"
    static let CELL_ID_USER_FEED_MAP_CELL                  = "UserFeedMapCell"
    static let CELL_ID_LIVE_SEARCH_CELL                    = "MuddleLiveSearchCell"
    static let CELL_ID_LIVE_SEARCH_HEADER_CELL             = "MuddleLiveSearchHeaderCell"
    static let CELL_ID_USER_ORDER_CELL                     = "UserOrderCell"
    static let CELL_ID_PROFILE_HEADER_CELL                 = "ProfileHeaderCell"
    static let CELL_ID_USER_PROFILE_DISH_CELL              = "UserProfileDishCell"
    static let CELL_ID_USER_ORDER_HEADERVIEW_CELL          = "UserOrderHeaderViewCell"
    static let CELL_ID_BUSINESS_PROMOTION_HEADERVIEW_CELL  = "BusinessListingHeaderViewCell"
    static let CELL_ID_ORDER_CONFIRMATION_CELL             = "OrderConfirmationCell"
    static let CELL_ID_FILTER_SELECTION_CELL               = "FilterSelectionCell"
    static let CELL_ID_BUSINESS_PROFILE_INFO_CELL          = "BusinessProfileInfoCell"
    static let CELL_ID_BUSINESS_PROFILE_SPECIALS_CELL      = "BusinessProfileSpecialsCell"
    static let CELL_ID_BUSINESS_PROFILE_COLLECTION_CELL    = "BusinessProfileCollectionViewCell"
    static let CELL_ID_BUSINESS_PROFILE_PHOTO_CELL         = "BusinessProfilePhotoCell"
    static let CELL_ID_BUSINESS_PROFILE_HEADERVIEW_CELL    = "BusinessProfileHeaderViewCell"
    static let CELL_ID_BUSINESS_PROFILE_HEADERVIEW         = "BusinessProfileHeaderView"
    static let CELL_ID_USER_INFO_SPECIAL_CELL              = "UserProfileSpecialsCell"
    static let CELL_ID_ORDER_DETAIL_CELL                   = "OrderDetailCell"
    
    static let CELL_ID_UPDATE_PAYMENT_INFORMATION          = "UpdatePaymentInformationCell"
    static let CELL_ID_PAST_OREDER_DETAIL_CELL             = "PastOrderDetailCell"
    static let CELL_ID_ORDER_CELL_LISTING                  = "UserProfileOrderCell"
}

//Log messages
struct LogMessages{
    static let LOG_BAD_IMPLEMENTATION        = "Bad Implementation!"
}

//Image name constants, binded with Images.xcassets
struct MuddleImages{
    static let IMG_USER_FAVOURITE_TAB_SELECTED        = "heart_filled"
    static let IMG_USER_FAVOURITE_TAB_NONSELECTED    = "heart_unfilled"
    
    static let IMG_USER_FEED_TAB_SELECTED            = "img_userfeed_tab_selected"
    static let IMG_USER_ORDER_TAB_SELECTED            = "img_userorder_tab_selected"
    static let IMG_USER_PROFILE_TAB_SELECTED        = "img_userprofile_tab_selected"
    
    static let IMG_USER_FEED_TAB_NONSELECTED        = "img_userfeed_tab_nonselected"
    static let IMG_USER_ORDER_TAB_NONSELECTED        = "img_userorder_tab_nonselected"
    static let IMG_USER_PROFILE_TAB_NONSELECTED     = "img_userprofile_tab_nonselected"
    
    // Business Tab Images
    
    static let IMG_ORDER_TAB_SELECTED                  = "img_bizorder_tab_selected"
    static let IMG_ORDER_CONFIRMATION_TAB_SELECTED     = "img_bizorderconfirmation_tab_selected"
    static let IMG_PROMOTION_TAB_SELECTED              = "img_bizpromotions_tab_selected"
    
    static let IMG_ORDER_TAB_NONSELECTED               = "img_bizorder_tab_nonselected"
    static let IMG_ORDER_CONFIRMATION_TAB_NONSELECTED  = "img_bizorderconfirmation_tab_nonselected"
    static let IMG_PROMOTION_TAB_NONSELECTED           = "img_bizpromotions_tab_nonselected"
    
    static let IMG_BUSINESS_MENU_LIST_TAB_SELECTED     = "img_business_menu_list_tab_selected"
    static let IMG_BUSINESS_MENU_LIST_TAB_NONSELECTED  = "img_business_menu_list_tab_nonselected"
    
    static let IMG_USER_ORDER_SEGMENT_SELECTED      = "img_selected_tab"
    static let IMG_USER_ORDER_SEGMENT_UNSELECTED    = "img_unselected_tab"
    static let IMG_HEART_UNFILLED                    = "heart_white"
    static let IMG_HEART_FILLED                     = "heart_filled"
    static let IMG_REFRESH                            = "refresh"
    
    static let IMG_TICK                             = "tick"
    static let IMG_UNTICK                            = "untick"
    static let IMG_SEARCH                            = "search"
    static let IMG_DOT                                = "dot"
    static let IMG_CAMERA                            = "camera"
    static let IMG_LOCATION                            = "location"
    static let IMG_SHARE                            = "share"
    static let IMG_FUNNEL                           = "funnel"
    
}

//Info.plist schemes (openURL)
struct URLSchemes{
    static let URL_SCHEME_INSTA        = "ig0df2029feb294d9f90a13e5aebd20f15"
    static let URL_SCHEME_FB        = "fb1856014721294121"
    static let URL_SCHEME_TWITTER    = ""
    static let URL_SCHEME_YELP        = ""
}

// Color Constants
struct MuddleColors{
    static let COLOR_THEME_BLUE = UIColor(red: 2/255.0, green: 69/255.0, blue: 105/255.0, alpha: 1.0)
    static let COLOR_SKY_BLUE = UIColor(red: 40/255.0, green: 130/255.0, blue: 188/255.0, alpha: 1.0)
    static let COLOR_DARK_GRAY = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1.0)
    static let COLOR_LIGHT_GRAY = UIColor(red: 83/255.0, green: 83/255.0, blue: 83/255.0, alpha: 1.0)
    static let COLOR_RED_BG = UIColor(red: 197/255.0, green: 56/255.0, blue: 52/255.0, alpha: 1.0)
    static let COLOR_Black = UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
    static let COLOR_Green = UIColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)
    static let COLOR_DARK_ORANGE = UIColor(red: 222/255.0, green: 143/255.0, blue: 78/255.0, alpha: 1.0)
}

// Font Constants
struct MuddleFonts{
    static let FONT_SANFRANCISCO_BOLD_16 = UIFont(name: "SanFranciscoText-Bold", size: 16)
    static let FONT_SANFRANCISCO_REGULAR = UIFont(name: "SanFranciscoText-Regular", size: 16)
    static let FONT_SANFRANCISCO_REGULAR_15 = UIFont(name: "SanFranciscoText-Regular", size: 15.0)
    static let FONT_SANFRANCISCO_REGULAR_20 = UIFont(name: "SanFranciscoText-Regular", size: 20.0)
    static let FONT_SANFRANCISCO_SEMIBOLD_25 = UIFont(name: "SanFranciscoText-Semibold", size: 25.0)
    static let FONT_SANFRANCISCO_THIN_8 = UIFont(name: "SanFranciscoDisplay-Thin", size: 8.0)
    static let FONT_SANFRANCISCO_THIN_13 = UIFont(name: "SanFranciscoDisplay-Thin", size: 13.0)
    static let FONT_SANFRANCISCO_THIN_12 = UIFont(name: "SanFranciscoDisplay-Thin", size: 12.0)
    static let FONT_SANFRANCISCO_THIN_15 = UIFont(name: "SanFranciscoDisplay-Thin", size: 15.0)
    static let FONT_SANFRANCISCO_THIN_16 = UIFont(name: "SanFranciscoDisplay-Thin", size: 16.0)
    static let FONT_SANFRANCISCO_THIN_17 = UIFont(name: "SanFranciscoDisplay-Thin", size: 17.0)
    static let FONT_SANFRANCISCO_THIN_18 = UIFont(name: "SanFranciscoDisplay-Thin", size: 18.0)
    static let FONT_SANFRANCISCO_THIN_22 = UIFont(name: "SanFranciscoDisplay-Thin", size: 22.0)
    static let FONT_SANFRANCISCO_THIN_70 = UIFont(name: "SanFranciscoDisplay-Thin", size: 25.0)
}

// Card Type

struct PTPCARD {
    static let AMERICAN_EXPRESS = "American Express"
    static let DINNERS_CLUB = "DinersClub"
    static let DISCOVER = "Discover"
    static let JCB = "JCB"
    static let MASTER_CARD = "MasterCard"
    static let VISA = "Visa"
}

struct StripeCardImages {
    static let amex = "img_stp_amex"
    static let dinnersClub = "img_stp_dinners"
    static let discover = "img_stp_discover"
    static let jcb = "img_stp_jcb"
    static let masterCard = "img_stp_mastercard"
    static let visa = "img_stp_visa"
    static let placeholder = "img_stp_placeholder"
}

struct PASSCODEOPERATION {
    static let SET = 0
    static let CHANGE = 1
    static let DEACTIVATED = 2
    static let ENTER = 3
}

struct PROMOTIONOPERATION {
    static let ADD = 0
    static let EDIT = 1
    static let REPEAT = 2
}

struct SCREENTOOPEN {
    static let ADDPAYMENT = 0
    static let VIEWPAYMENTHIS = 1
    static let EMAIL = 2
    static let PASSWORD = 3
    static let PERSONAL_NUMBER = 4
    static let PROFILE_PICTURE = 5
    static let ABOUT = 6
    static let NEWPROMOTION = 7
    static let EDITPROMOTION = 8
    static let DELETEPROMOTION = 9
}

struct NotificationName {
    static let NOTIFICATION_RELOADDATA        = "NotificationReloadData"
    static let NOTIFICATION_RELOADFAVDATA        = "NotificationReloadFavData"
}

let DEFAULTMAPAREA = 1.0
