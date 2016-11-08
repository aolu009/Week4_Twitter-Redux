//
//  HamburgerViewController.swift
//  Week3_Simple Twitter Client
//
//  Created by Lu Ao on 11/6/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstrain: NSLayoutConstraint!
    var originalLeftMargin: CGFloat! 
    
    var menuViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            if oldContentViewController != nil{
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            menuViewController.willMove(toParentViewController: self)
            self.menuView.addSubview(menuViewController.view)
            menuViewController.willMove(toParentViewController: self)
        }
    }
    
    var contentViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            if oldContentViewController != nil{
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            contentViewController.willMove(toParentViewController: self)
            self.contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 1, animations: {
                self.leftMarginConstrain.constant = 0
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onPanningRight(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        
        if panGestureRecognizer.state == .began {
            
            self.originalLeftMargin = leftMarginConstrain.constant
            
        } else if panGestureRecognizer.state == .changed {
            
            leftMarginConstrain.constant = self.originalLeftMargin + translation.x
            
        } else if panGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.5, animations: {
                if velocity.x > 0{
                    self.leftMarginConstrain.constant = self.view.frame.width - 50
                }
                else{
                    self.leftMarginConstrain.constant = 0
                }
                self.view.layoutIfNeeded()
            }, completion: { (Bool) in
                
            })
            
        }
    }
    
}
