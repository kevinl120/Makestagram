//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Kevin Li on 7/1/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

// This is the main View Controller of the app
class TimelineViewController: UIViewController {

    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set TimelineViewController to be tabBarController's delegate
        self.tabBarController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func takePhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            // Nothing yet...
            println("received a callback")
        })
    }
}


// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    // Deactivates photo view controller so we can show an action dialog instead of switching to a view controller
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController is PhotoViewController {
            takePhoto()
            return false
        } else {
            return true
        }
    }
}