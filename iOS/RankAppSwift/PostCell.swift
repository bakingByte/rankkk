//
//  PostCell.swift
//  RankAppSwift
//
//  Created by Santosh Maurya on 22/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDiscrobtion: UILabel!
    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnDisLike: UIButton!
    
    @IBOutlet weak var btnComment: UIButton!
    
    @IBOutlet weak var btnShare: UIButton!
    
    
    
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblDisLikeCount: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
