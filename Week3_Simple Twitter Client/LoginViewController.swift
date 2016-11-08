//
//  ViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 10/28/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onLoginButtton(_ sender: AnyObject) {
        TweetClient.shareInstance?.login(success: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hamburgerViewController = storyboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
            self.present(hamburgerViewController, animated: true, completion: { 
            print("Success")
            })
            print("Login Sucessfully")
        }, failure: { (Error) in
            print("Login Error:\(Error.localizedDescription)")
        })
        
    }
    
}

