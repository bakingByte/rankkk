//
//  ChefTableViewCell.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 05/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ChefTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImageView: UIView!
    @IBOutlet weak var professionLabel: UILabel!
   
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
