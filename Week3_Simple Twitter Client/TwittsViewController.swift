//
//  TweetsViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/29/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

protocol TwittsViewControllerDelegate {
    func twittsViewController(TwittsViewController:TwittsViewController, user:User)
}

class TwittsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, NewPostViewControllerDelegate,RespondViewControllerDelegate,NewPostViewControllerDataSource,TweetTableViewCellDatasource {
    
   
    @IBOutlet weak var tweetsTable: UITableView!
    
    var tweets : [Tweet]?
    var tweetSelected: Tweet?
    var replyPressed: Bool = false
    var user : User?
    var delegate : TwittsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Timeline Laoded")
        // add refresh control to table view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tweetsTable.insertSubview(refreshControl, at: 0)
        tweetsTable.estimatedRowHeight = 300
        tweetsTable.rowHeight = UITableViewAutomaticDimension
        // Load time line
        TweetClient.shareInstance?.timeline(success: { (tweets) in
            self.tweets = tweets
            self.tweetsTable.reloadData()
        }, failure: { (Error) in
            print("Error retrieving tweet:\(Error)")
        })
        TweetClient.shareInstance?.verifyCredential(success: { (User) in
            self.user = User
        }, failure: { (Error) in
            print("Fetch User Info Error:",Error)
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
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetcell") as! TweetTableViewCell
            cell.dataSource = self
            cell.replyButton.tweetInfo = self.tweets?[indexPath.row]
            cell.postText.text = self.tweets?[indexPath.row].text
            let urlString = self.tweets?[indexPath.row].user?.profileUrl
            cell.userProfilePic.setImageWith(urlString!)
            cell.timeStamp.text =  self.tweets?[indexPath.row].timeinterval!
            cell.name.text = self.tweets?[indexPath.row].user?.name
            if let screenname = self.tweets?[indexPath.row].user?.screenname{
                cell.screen_name.text = "@\(screenname)"
            }
        
            return cell
    }
    // On Logout
    @IBAction func onLogout(_ sender: Any) {
        TweetClient.shareInstance?.logout()
    }
    // On New
    @IBAction func onNew(_ sender: Any) {
        self.delegate?.twittsViewController(TwittsViewController: self, user: self.user!)
    }
    
    // On Tabbing a tweet
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        self.tweetSelected = self.tweets?[indexPath.row]
    }
    
    
    // Refresh Control Event
    func refreshControlAction(refreshControl: UIRefreshControl){
        print("Reloading")
        TweetClient.shareInstance?.timeline(success: { (tweets) in
            self.tweets = tweets
            self.tweetsTable.reloadData()
            refreshControl.endRefreshing()
            print("Done Reload!!")
        }, failure: { (Error) in
            print("Error retrieving tweet:\(Error)")
        })
    }
    
    // Delegates
    func newPostViewController(NewPostViewController: NewPostViewController, tweet: Tweet) {
        print("New post received")
        self.tweets?.insert(tweet, at: 0)
        self.tweetsTable.reloadData()
    }
    func respondViewController(RespondViewController: RespondViewController, tweet: Tweet) {
        print("New post received")
        self.tweets?.insert(tweet, at: 0)
        self.tweetsTable.reloadData()
    }
    func newPostViewController() -> String {
        return "Data Source Works!!"
    }
    func tweetTableViewCell(tweet: Tweet,replyPressed: Bool ) {
        self.tweetSelected = tweet
        self.replyPressed = replyPressed
        print("Tweet selected here")
    }
    // try to transition below to delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNvc = segue.destination as! UINavigationController
        if segue.identifier == "respond" || segue.identifier == "reply"{
            print("testing!")
            let destinationVC = destinationNvc.topViewController as! RespondViewController
            if segue.identifier == "reply"{
                destinationVC.replyingTweet = self.tweetSelected
            }
            else{
                let indexPath = tweetsTable.indexPath(for: sender as! TweetTableViewCell)
                destinationVC.replyingTweet = self.tweets?[(indexPath?.row)!]
            }
            destinationVC.delegate = self
        }
        if segue.identifier == "NewPost"{
            let destinationVC = destinationNvc.topViewController as! NewPostViewController
            destinationVC.userInfo = self.user
            destinationVC.datasource = self
            destinationVC.delegate = self
        }
        if segue.identifier == "ProfileSegue"{
            let destinationVC = destinationNvc.topViewController as! UserProfileTimelineViewController
            destinationVC.userName = self.tweetSelected?.screenname
            
        }
        
        
    }
    
}
