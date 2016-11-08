//
//  MenuViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/6/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//
//Let Things "ONLY loads in the container"

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var menuList: [String] = ["Profile","Home Timeline","Mentions"]
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController?
    var timelineViewController: UIViewController?
    var userProfileTimelineViewController: UIViewController?
    var mentionsViewController: UIViewController?
    var testing: LoginViewController?
    
    //var tweetNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.timelineViewController = storyboard.instantiateViewController(withIdentifier: "tweetNavigationController")
        self.userProfileTimelineViewController = storyboard.instantiateViewController(withIdentifier: "UserProfileTimelineNavViewController")
        self.mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsNavViewController")
        viewControllers.append(self.userProfileTimelineViewController!)
        viewControllers.append(self.timelineViewController!)
        viewControllers.append(self.mentionsViewController!)
        hamburgerViewController?.contentViewController = self.timelineViewController
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menu?.text = menuList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController?.contentViewController = self.viewControllers[indexPath.row]
    }
}
