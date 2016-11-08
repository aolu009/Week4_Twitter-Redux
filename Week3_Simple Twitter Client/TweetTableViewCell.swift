//
//  TweetTableViewCell.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/29/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit
protocol TweetTableViewCellDatasource {
    func tweetTableViewCell(tweet: Tweet, replyPressed: Bool)
}


class TweetTableViewCell: UITableViewCell,RespondViewControllerDataSource {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screen_name: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var replyButton: ReplyButton!
    var tweetInfo: Tweet?
    var dataSource: TweetTableViewCellDatasource?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let tweet = self.tweetInfo{
            replyButton.tweetInfo = tweet
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onReply(_ sender: Any) {
        self.dataSource?.tweetTableViewCell(tweet: replyButton.tweetInfo!, replyPressed: true)
        
    }
    
    @IBAction func onProfilePic(_ sender: Any) {
        self.dataSource?.tweetTableViewCell(tweet: replyButton.tweetInfo!, replyPressed: true)
    }
    
    
    
    func respondViewController() -> Tweet {
        return replyButton.tweetInfo!
    }
    
    

}
