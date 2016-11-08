//
//  RespondViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/31/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

protocol RespondViewControllerDelegate {
    func respondViewController(RespondViewController:RespondViewController, tweet: Tweet)
}
protocol RespondViewControllerDataSource {
    func respondViewController() -> Tweet
}

class RespondViewController: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var handleName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var wordcount: UILabel!
    @IBOutlet weak var replyText: UITextView!
    
    var replyingTweet : Tweet?
    var delegate : RespondViewControllerDelegate?
    var dataSource: RespondViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyText.delegate = self
        self.replyingTweet = self.replyingTweet ?? self.dataSource?.respondViewController()
        self.userProfilePic.setImageWith((self.replyingTweet?.user?.profileUrl)!)
        self.userName.text = self.replyingTweet?.user?.name
        if let handle = replyingTweet?.screenname{
            replyText.text = "@\(handle) "
            self.handleName.text = "@\(handle)"
        }
        if let postText = self.replyingTweet?.text{
            self.tweetText.text = postText
        }
        
    }

    @IBAction func replySend(_ sender: Any) {
        TweetClient.shareInstance?.compose(reply: true, postId: replyingTweet?.postId, tweetString: replyText.text, success: { (dictionary) in
            self.replyingTweet = Tweet.init(dictionary: dictionary)
            self.delegate?.respondViewController(RespondViewController: self, tweet: self.replyingTweet!)
            self.dismiss(animated: true, completion: nil)
        }, failure: { (Error) in
            print("Error replying tweet:\(Error)")
        })
        
    }

    @IBAction func retweeted(_ sender: Any) {
        TweetClient.shareInstance?.retweet(tweetId: (replyingTweet?.postId)!, success: { (dictionary) in
            self.replyingTweet = Tweet.init(dictionary: dictionary)
            self.delegate?.respondViewController(RespondViewController: self, tweet: self.replyingTweet!)
            self.dismiss(animated: true, completion: nil)
        }, failure: { (Error) in
            print("Error retweeting tweet:\(Error)")
        })
        
    }
    
    @IBAction func liked(_ sender: Any) {
        TweetClient.shareInstance?.favorite(tweetId: (replyingTweet?.postId)!, success: { (dictionary) in
            self.replyingTweet = Tweet.init(dictionary: dictionary)
            self.delegate?.respondViewController(RespondViewController: self, tweet: self.replyingTweet!)
            self.dismiss(animated: true, completion: nil)
        }, failure: { (Error) in
            print("Error Liking tweet:\(Error)")
        })
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.replyText.text.characters.count == 141{
            self.replyText.deleteBackward()
        }
        let wordRemaining = 140 - self.replyText.text.characters.count
        self.wordcount.text = String(describing: wordRemaining )
    }
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
