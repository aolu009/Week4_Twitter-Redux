//
//  MentionsTableViewCell.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/7/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class MentionsTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var postText: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
