//
//  Tweet.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/29/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text : String?
    var timeStamp : NSDate?
    var retwittCount : Int? = 0
    var favoriteCount: Int? = 0
    var user : User?
    var postId : String?
    var screenname : String!
    var timeinterval : String?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        favoriteCount = dictionary["favourites_count"] as? Int
        retwittCount = dictionary["retweet_count"] as? Int
        user = User.init(dictionary: dictionary["user"] as! NSDictionary)
        screenname = user?.screenname
        postId = dictionary["id_str"] as? String
        let timeString = dictionary["created_at"] as? String
        if let timeString = timeString{
            let formatter = DateFormatter()
            //Tue Aug 28 21:16:23 +0000 2012
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeString) as NSDate?
            if Int(timeStamp!.timeIntervalSinceNow) < -21600{
                timeinterval = String(describing: Int(timeStamp!.timeIntervalSinceNow.divided(by: -21600))) + "d"
            }
            else if Int(timeStamp!.timeIntervalSinceNow) < -3600 {
                timeinterval = String(describing: Int(timeStamp!.timeIntervalSinceNow.divided(by: -21600))) + "h"
            }
            else{
                timeinterval = String(describing: Int(timeStamp!.timeIntervalSinceNow.divided(by: -60))) + "m"
            }
            
        }
    }
    
    class func twittWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
