//
//  ViewControllerHelper.swift
//  Umahh
//
//  Created by mac on 06/03/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
enum ViewControllerType{
    
    case loginVC
    case IntroVC
    case signupVC
    case changepasswordVC
    case accounttypeVC
    case verificationVC
    case forgetVC
    case buss_ownersignup
    case selectmosque
     case home
    case mosquedetail
    case board
    case khutba
    case calendar
    case Edulist
     case EduDetail
    case suggestion
    case activitiesList
    case activitiesDetail
    case newsList
     case newsDetail
    case assocation
    case donation
    case feed
    case Quranlist
    case CommunityList
    case settings
    case Qiblah
    case Quiz
    case personage
    case Zakat_calc
    case Hajiumrah
    case Hajiumrahdetail
    case Supplication
    case Supplicationdetail
    case business
    case businessdetail
    case Organization
    case Bookmark
    case Search
    case mosqueAccount
     case mosqueListNearby
     case prayertime
     case addCommnunity
     case hajiumrahdetailContent
    case mosqueMap
     case ProfileVc
    case businessdetailfinal
     case mosquelistVC
    case specialdonate
    case Qurandetail
    case followVC
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType:ViewControllerType)->UIViewController{
        
        var viewController:UIViewController?
        
        if viewControllerType == .loginVC{
            viewController = LoginVC(nibName: NibNames.NIB_LOGINVC, bundle: nil)
        }
        else if(viewControllerType == .IntroVC){
            viewController = IntroVC(nibName: NibNames.NIB_INTROVC, bundle: nil)
        }
        else if(viewControllerType == .signupVC){
            viewController = SignupVC(nibName: NibNames.NIB_Signupvc, bundle: nil)
        }
        else if(viewControllerType == .changepasswordVC){
            viewController = ChangePasswordVC(nibName: NibNames.NIB_ChangePassword, bundle: nil)
        }
        else if(viewControllerType == .accounttypeVC){
            viewController = AccountTypeVC(nibName: NibNames.NIB_AccountType, bundle: nil)
        }
        else if(viewControllerType == .verificationVC){
            viewController = VerificationVC(nibName: NibNames.NIB_Verification, bundle: nil)
        }
        else if(viewControllerType == .forgetVC){
            viewController = ForgetVc(nibName: NibNames.NIB_ForgetPassword, bundle: nil)
        }
        else if(viewControllerType == .buss_ownersignup){
            viewController = BusinessOwnerSignupVC(nibName: NibNames.NIB_OwnerAccount, bundle: nil)
        }
        else if(viewControllerType == .mosqueAccount){
            viewController = MosqueSignVC(nibName: NibNames.NIB_MosqueAccount, bundle: nil)
        }
        else if(viewControllerType == .mosquedetail){
            viewController = MosqueDetailVC(nibName: NibNames.NIB_mosquedetail, bundle: nil)
        }
        else if(viewControllerType == .selectmosque){
            viewController = SelectMosqueVC(nibName: NibNames.NIB_selectmosque, bundle: nil)
        }
        else if(viewControllerType == .home){
            viewController = HomeVC(nibName: NibNames.NIB_home, bundle: nil)
        }
        else if(viewControllerType == .mosquedetail){
            viewController = MosqueDetailVC(nibName: NibNames.NIB_mosquedetail, bundle: nil)
        }
        else if(viewControllerType == .board){
            viewController = BaordVC(nibName: NibNames.NIB_board, bundle: nil)
        }
        else if(viewControllerType == .khutba){
            viewController = KhutbaVC(nibName: NibNames.NIB_khutba, bundle: nil)
        }
        else if(viewControllerType == .calendar){
            viewController = CalendorVC(nibName: NibNames.NIB_Calendor, bundle: nil)
        }
        else if(viewControllerType == .Edulist){
            viewController = EducationListVC(nibName: NibNames.NIB_EduList, bundle: nil)
        }
        else if(viewControllerType == .suggestion){
            viewController = SuggestionVC(nibName: NibNames.NIB_Suggestion, bundle: nil)
        }
        else if(viewControllerType == .activitiesList){
            viewController = ActivityList(nibName: NibNames.NIB_ActiList, bundle: nil)
        }
        else if(viewControllerType == .activitiesDetail){
            viewController = ActivityDetail(nibName: NibNames.NIB_ActiListDetail, bundle: nil)
        }
            
        else if(viewControllerType == .newsList){
            viewController = NewsList(nibName: NibNames.NIB_NewsList, bundle: nil)
        }
        else if(viewControllerType == .assocation){
            viewController = AssociationList(nibName: NibNames.NIB_Associates, bundle: nil)
        }
        else if(viewControllerType == .donation){
            viewController = DonateVC(nibName: NibNames.NIB_Donate, bundle: nil)
        }
        else if(viewControllerType == .feed){
            viewController = FeedVc(nibName: NibNames.NIB_Feed, bundle: nil)
        }
        else if(viewControllerType == .Quranlist){
            viewController = QuranListVC(nibName: NibNames.NIB_Quran, bundle: nil)
        }
        else if(viewControllerType == .CommunityList){
            viewController = CommunityListVC(nibName: NibNames.NIB_Community, bundle: nil)
        }
        else if(viewControllerType == .settings){
            viewController = SettingsVC(nibName: NibNames.NIB_Settings, bundle: nil)
        }
        else if(viewControllerType == .Qiblah){
            viewController = QuiblaVC(nibName: NibNames.NIB_Qiblah, bundle: nil)
        }
        else if(viewControllerType == .Quiz){
            viewController = QuizList(nibName: NibNames.NIB_Quiz, bundle: nil)
        }
        else if(viewControllerType == .personage){
            viewController = PersonangeVC(nibName: NibNames.NIB_Personnage, bundle: nil)
        }
        else if(viewControllerType == .Zakat_calc){
            viewController = ZakatCalcVC(nibName: NibNames.NIB_Zakat_calc, bundle: nil)
        }
        else if(viewControllerType == .Hajiumrah){
            viewController = HajiUmrahVC(nibName: NibNames.NIB_Hajiumrah, bundle: nil)
        }
        else if(viewControllerType == .Supplication){
            viewController = SupplicationVC(nibName: NibNames.NIB_Supplication, bundle: nil)
        }
        else if(viewControllerType == .business){
            viewController = BusinessVC(nibName: NibNames.NIB_Business, bundle: nil)
        }
        else if(viewControllerType == .Organization){
            viewController = OrganizationVC(nibName: NibNames.NIB_Organization, bundle: nil)
        }
        else if(viewControllerType == .Bookmark){
            viewController = BookmarkVC(nibName: NibNames.NIB_BookmarkVC, bundle: nil)
        }
        else if(viewControllerType == .Search){
            viewController = SearchVC(nibName: NibNames.NIB_Search, bundle: nil)
        }
        else if(viewControllerType == .mosqueListNearby){
            viewController = MosqueListVC(nibName: NibNames.NIB_mosquelist, bundle: nil)
        }
        else if(viewControllerType == .newsDetail){
            viewController = NewsDetail(nibName: NibNames.NIB_NewsDetail, bundle: nil)
        }
        else if(viewControllerType == .prayertime){
            viewController = PrayerTimeVC(nibName: NibNames.NIB_prayertime, bundle: nil)
        }
        else if(viewControllerType == .Hajiumrahdetail){
            viewController = HajiListVC(nibName: NibNames.NIB_HajiumrahVC, bundle: nil)
        }
        else if(viewControllerType == .Supplicationdetail){
            viewController = SupplicationDetailVC(nibName: NibNames.NIB_SuplicationDetail, bundle: nil)
        }
        else if(viewControllerType == .businessdetail){
            viewController = BusinessDetailVC(nibName: NibNames.NIB_BusinessDetail, bundle: nil)
        }
        else if(viewControllerType == .addCommnunity){
            viewController = AddNewRequest(nibName: NibNames.NIB_AddCommunity, bundle: nil)
        }
        else if(viewControllerType == .hajiumrahdetailContent){
            viewController = UmrahListVC(nibName: NibNames.NIB_umrahcontentdetail, bundle: nil)
        }
        else if(viewControllerType == .EduDetail){
            viewController = EducationDetailVC(nibName: NibNames.NIB_edudetail, bundle: nil)
        }
        else if(viewControllerType == .mosqueMap){
            viewController = MosqueMapVC(nibName: NibNames.NIB_mosqueMap, bundle: nil)
        }
        else if(viewControllerType == .ProfileVc){
            viewController = ProfileVC(nibName: NibNames.NIB_profilevc, bundle: nil)
        }
        else if(viewControllerType == .businessdetailfinal){
            viewController = BusinessDetailFinalVC(nibName: NibNames.NIB_businessdetailfinal, bundle: nil)
        }
        else if(viewControllerType == .mosquelistVC){
            viewController = MosquelistVC(nibName: NibNames.NIB_mosquelistVC, bundle: nil)
        }
        else if(viewControllerType == .specialdonate){
            viewController = FirstDonationVC(nibName: NibNames.NIB_specialdonate, bundle: nil)
        }
        else if(viewControllerType == .Qurandetail){
            viewController = QuranDetailVC(nibName: NibNames.NIB_qurandetail, bundle: nil)
        }
        else if(viewControllerType == .followVC){
            viewController = FollowVC(nibName: NibNames.NIB_followvc, bundle: nil)
        }
        else
        {
            print("Unknown view controller type")
        }
        
        if let vc = viewController{
            return vc
        }else{
            return UIViewController()
        }
    }
    
    //    class func getNavVC(of viewController:UIViewController)->MuddleNavVC?{
    //        return (viewController.navigationController as? MuddleNavVC) // It will get the navigation controller from view controller.
    //    }
    
}
