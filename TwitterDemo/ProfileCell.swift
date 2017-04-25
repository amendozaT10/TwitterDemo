//
//  ProfileCell.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/24/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    var user: User! {
        didSet {
            profileName.text = user.name as String?
            profileUsername.text = "@" + (user!.screename! as String)
            tweetCount.text = "\(user.tweetsCount!)"
            followingCount.text = "\(user.following!)"
            followersCount.text = "\(user.followersCount!)"
            profileImage.setImageWith(user.profileURL! as URL)
            
            let background = user.backgroundURL
            if let background = background {
                coverImage.setImageWith(background as URL)

            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 5
        profileImage.clipsToBounds = true
        coverImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
