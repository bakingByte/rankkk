//
//  DashboardPostCollectionViewCell.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 08/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class DashboardPostCollectionViewCell: UICollectionViewCell {
    
    weak var delegate:NavigationViewDelegate?
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDiscrobtion: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblDisLikeCount: UILabel!
    
    var profileImages:NSArray = ["bitmap.png","bitmapCopy.png","bitmapCopy2.png","bitmapCopy3.png","bitmapCopy4.png","bitmapCopy5.png","bitmapCopy6.png","bitmapCopy7.png","bitmapCopy8.png","bitmapCopy8.png"]
    
    var likeCount = 0
    var dic:NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setFeedValueOnView(feedDic :NSDictionary, imgName :NSString)
    {
        print(feedDic)
        print(imgName)
        
        
        dic = feedDic
        print(dic ?? "")
        
        lblTitle.text = feedDic["title"] as? String ?? ""
        lblDiscrobtion.text = feedDic["title"] as? String ?? ""
        lblLikeCount.text = feedDic["like"] as? String ?? ""
        lblDisLikeCount.text = feedDic["dislike"] as? String ?? ""
        lblCommentCount.text = feedDic["comment"] as? String ?? ""
        
        let image = UIImage(named: imgName as String)
        imgPost.image = image

    }

    
    @IBAction func btnLikeButtonAction(_ sender: Any) {
        let myString = lblLikeCount.text
        let myInt = Int(myString!)
        let b = myInt! + 1
        let c = String(b)
        self.lblLikeCount.text = c
        
        self.delegate?.likePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    
    @IBAction func btnDisLikeButtonAction(_ sender: Any) {
        
        let myString = lblDisLikeCount.text
        let myInt = Int(myString!)
        let b = myInt! - 1
        let c = String(b)
        self.lblDisLikeCount.text = c
        
        self.delegate?.disLikePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    @IBAction func btnCommentButtonAction(_ sender: Any) {
        self.delegate?.commentPost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    @IBAction func btnShareButtonAction(_ sender: Any) {
        self.delegate?.sharePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    
//    @IBOutlet weak var profileImgView: UIImageView!
//    @IBOutlet weak var postImgView: UIImageView!
//    @IBOutlet weak var nameLbl: UILabel!
    }
