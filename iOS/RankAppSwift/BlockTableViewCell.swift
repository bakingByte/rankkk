//
//  BlockTableViewCell.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 24/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class BlockTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameID: UILabel!
    
    @IBOutlet weak var unBlockBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
