//
//  UserTimelineViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/7/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//
//Displaying other users timeline
//Can be reuse by self own timeline as a profile page


import UIKit

class UserProfileTimelineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var profileTable: UITableView!
    var UserPorfile: User?
    var tweets : [Tweet]?
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.estimatedRowHeight = 300
        profileTable.rowHeight = UITableViewAutomaticDimension
        self.userName = self.userName ?? "aolu009"
        
        if self.userName == "aolu009"{
            self.navigationItem.leftBarButtonItem = nil
            
        }
        TweetClient.shareInstance?.getUserInfo(screen_name: userName!, success: { (User) in
            self.UserPorfile = User
            self.profileTable.reloadData()
        }, failure: { (Error) in
            print("Error fetching userdata")
        })

        TweetClient.shareInstance?.userTimeline(screen_name: userName!, success: { (tweets) in
            self.tweets = tweets
            self.profileTable.reloadData()
        }, failure: { (Error) in
            print("Error!!!!!!!")
        })
       
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            if let tweets = self.tweets{
                return tweets.count
            }
            else{
                return 0
            }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableViewCell
            
            if let imageUrl = self.UserPorfile?.dictionary?["profile_banner_url"]{
                cell.backGroundImage.setImageWith(URL(string:imageUrl as! String)!)
            }
            
            if let imageUrl = self.UserPorfile?.dictionary?["profile_image_url_https"]{
                cell.profilePic.setImageWith(URL(string:imageUrl as! String)!)
            }
            
            cell.name.text = self.UserPorfile?.name
            if let screenName = self.UserPorfile?.screenname{
                cell.screenName.text = "@\(screenName)"
            }
            cell.numOfFollowers.text = self.UserPorfile?.numOfFollowers
            cell.numOfTweets.text = self.UserPorfile?.numOfTweet
            cell.numOgFollowings.text = self.UserPorfile?.numOfFollowings
            //let urlString = self.UserPorfile?.profileBkGndImageUrl!
            //cell.profilePic.setImageWith(urlString!)
            return cell
        }
        else{//ProfileTweesTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweesTableViewCell") as! ProfileTweesTableViewCell
            cell.tweetText.text = self.tweets?[indexPath.row].text
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
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
