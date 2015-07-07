//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Kevin Li on 7/1/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

// This is the main View Controller of the app
class TimelineViewController: UIViewController {

    var posts: [Post] = []
    
    @IBOutlet var tableView: UITableView!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set TimelineViewController to be tabBarController's delegate
        self.tabBarController?.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.timelineRequestforCurrentUser {
            (result: [AnyObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
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
            let post = Post()
            post.image.value = image!
            post.uploadPost()
        })
    }
}

extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        let post = posts[indexPath.row]
        post.downloadImage()
        post.fetchLikes()
        cell.post = post
        
        return cell
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