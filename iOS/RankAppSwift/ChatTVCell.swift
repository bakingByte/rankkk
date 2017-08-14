//
//  ChatTVCell.swift
//  RankAppSwift
//
//  Created by ABCD on 05/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ChatTVCell: UITableViewCell {

    @IBOutlet weak var chatperson_image: UIImageView!
    @IBOutlet weak var charperson_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
