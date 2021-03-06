//
//  User.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/29/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var screenname : String?
    var profileUrl : URL?
    var profileBkGndImageUrl: URL?
    var tagline: String?
    var dictionary : NSDictionary?
    var numOfTweet: String?
    var numOfFollowings: String?
    var numOfFollowers: String?
    //# tweets, # following, # followers //followers_count //following, statuses_count
        
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        let profilebackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        self.numOfTweet = String(dictionary["statuses_count"] as! Int)
        self.numOfFollowers = String(dictionary["followers_count"] as! Int)
        self.numOfFollowings = String(dictionary["friends_count"] as! Int)
        
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        }
        if let profilebackgroundUrlString = profilebackgroundUrlString{
            profileBkGndImageUrl = URL(string: profilebackgroundUrlString)
        }
        tagline = dictionary["description"] as? String
        
    }
    
    static var _currentUser: User?
    class var currentUser: User?{
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                if let userData = userData{
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }

                
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data,forKey: "currentUserData")
            }
            else{
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
