//
//  ProfileTableViewCell.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/7/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var numOfTweets: UILabel!
    @IBOutlet weak var numOgFollowings: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
