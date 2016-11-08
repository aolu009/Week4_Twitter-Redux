//
//  NewPostViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/1/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

protocol NewPostViewControllerDelegate {
    func newPostViewController(NewPostViewController:NewPostViewController, tweet: Tweet)
}
protocol NewPostViewControllerDataSource {
    func newPostViewController() -> String
}


class NewPostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetSending: UIButton!
    @IBOutlet weak var sendTweet: UIBarButtonItem!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandleName: UILabel!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var postText: UITextView!
    
    
    var delegate : NewPostViewControllerDelegate?
    var datasource : NewPostViewControllerDataSource?
    var userInfo: User?
    var newTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userInfo = self.userInfo{
            self.userImage.setImageWith(userInfo.profileUrl!)
            self.userName.text = userInfo.name
            self.userHandleName.text = userInfo.screenname
        }
        if let testString = self.datasource?.newPostViewController(){
            print(testString)
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostTweet(_ sender: Any) {
        TweetClient.shareInstance?.compose(reply: false, postId: nil, tweetString: self.postText.text, success: { (dictionary) in
            self.newTweet = Tweet.init(dictionary: dictionary)
            self.delegate?.newPostViewController(NewPostViewController: self, tweet: self.newTweet!)
            self.dismiss(animated: true, completion: nil)
            
        }, failure: { (Error) in
            print("Error:\(Error)")
        })
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.postText.text.characters.count == 141{
            self.postText.deleteBackward()
        }
        if textView.text.characters.count > 1{
            self.tweetSending.setImage(UIImage(named:"TweetButtonOn"), for: .normal)
            
            self.sendTweet.isEnabled = true
        }
        else{
            self.sendTweet.image = #imageLiteral(resourceName: "TweetButtonOff")
            self.tweetSending.isEnabled = false
            //self.sendTweet.isEnabled = false
        }
        let wordRemaining = 140 - self.postText.text.characters.count
        self.wordCount.text = String(describing: wordRemaining )
    }
    
    func twittsViewController(TwittsViewController: TwittsViewController, user: User) {
        self.userInfo = user
        print("Got it")
    }
    
}
