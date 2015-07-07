//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Kevin Li on 7/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likesIconImageView: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    
    var likeBond: Bond<[PFUser]?>!
    
    var post: Post? {
        didSet {
            if let post = post {
                // bind the image of the post to the 'postImage' view
                post.image ->> postImageView
                
                // bind the likeBond to update like label and button when likes change
                post.likes ->> likeBond
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        likeBond = Bond<[PFUser]?>() { [unowned self] likeList in
            if let likeList = likeList {
                self.likesLabel.text = self.stringFromUserList(likeList)
                self.likeButton.selected = contains(likeList, PFUser.currentUser()!)
                self.likesIconImageView.hidden = (likeList.count == 0)
            } else {
                // if there is no list of users that like this post, reset everything
                self.likesLabel.text = ""
                self.likeButton.selected = false
                self.likesIconImageView.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        
    }
    
    func stringFromUserList(userList: [PFUser]) -> String {
        let usernameList = userList.map{user in user.username!}
        let commaSeparatedList = ", ".join(usernameList)
        
        return commaSeparatedList
    }
    

}
