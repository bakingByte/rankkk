//
//  NavigationViewDelegate.swift
//  RankAppSwift
//
//  Created by Santosh Maurya on 23/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import Foundation
@objc protocol NavigationViewDelegate: class
{
//    @objc optional func  moreButtonClick(_ sender: AnyObject,feedDetails:NSDictionary, index:Int, section:Int)
//    @objc optional func  stylistDicCell(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    
//    // @objc optional func  editButtonAction(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  deleteButtonAction(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  bookButtonAction(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  indexSegmentSelection(_ sender: AnyObject, index:Int)
//    
//    @objc optional func  TopButtonClick(_ sender: AnyObject, index:Int)
//    @objc optional func  PostButtonClick(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    
//    @objc optional func  FeedProfileImgClick(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  FeedImgClick(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    @objc optional func  commentPost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    @objc optional func  likePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    @objc optional func  disLikePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    @objc optional func  sharePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    
//    @objc optional func updateDataForlike_comment(islike:Int,updatedDict:NSDictionary,commentCount:Int) // used in appointment confirm class
//    @objc optional func  portfolioBookButtonAction(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  pushWhenClickOnReviewButton()
//    
//    @objc optional func  stylist4ToShape()
//    
//    @objc optional func getSearchListofStylistandServices(suggestionName:String,request_Details:NSDictionary)
//    @objc optional func getSearchListofStylist(searchText:String,request_Details:NSDictionary)
//    @objc optional func subscribed(sender: AnyObject, subsriberDetails: NSDictionary ,is_subscribe:String)
}

