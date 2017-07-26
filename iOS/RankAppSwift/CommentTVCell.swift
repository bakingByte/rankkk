//
//  CommentTVCell.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 07/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class CommentTVCell: UITableViewCell {

    @IBOutlet weak var likeImgView: UIImageView!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var personImgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
