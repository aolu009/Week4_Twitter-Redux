//
//  MenuTableViewCell.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/6/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
