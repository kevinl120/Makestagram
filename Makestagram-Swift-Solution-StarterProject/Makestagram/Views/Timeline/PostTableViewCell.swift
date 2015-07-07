//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Kevin Li on 7/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likesIconImageView: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    
    var post: Post? {
        didSet {
            if let post = post {
                post.image ->> postImageView
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
        
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        
    }
    

}
