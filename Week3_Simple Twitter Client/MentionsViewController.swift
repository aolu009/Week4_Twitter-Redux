//
//  MentionsViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/7/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mentionsTable: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mentionsTable.delegate = self
        self.mentionsTable.dataSource = self
        TweetClient.shareInstance?.getMentions(success: { (tweets) in
            self.tweets = tweets
            self.mentionsTable.reloadData()
        }, failure: { (Error) in
            print("Mentions fails")
        })

        
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionsTableViewCell") as! MentionsTableViewCell
        cell.postText.text = self.tweets?[indexPath.row].text
        let urlString = self.tweets?[indexPath.row].user?.profileUrl
        cell.userProfilePic.setImageWith(urlString!)
        cell.timeStamp.text =  self.tweets?[indexPath.row].timeinterval!
        cell.name.text = self.tweets?[indexPath.row].user?.name
        if let screenname = self.tweets?[indexPath.row].user?.screenname{
            cell.screenName.text = "@\(screenname)"
        }
        
        return cell
    }
}
