//
//  TweetOption.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/16/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class TweetOption: UITableViewCell {
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var favorited: Bool?
    var retweeted: Bool?
    
    var tweet: Tweet! {
        didSet{
            if tweet.isRetweeted! {
                retweetImage.image = #imageLiteral(resourceName: "retweet_on")
                retweeted = true
            } else {
                retweeted = false
            }
            
            if tweet.isFavorited! {
                favoriteImage.image = #imageLiteral(resourceName: "favorite_on")
                favorited = true
            } else {
                favorited = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorited() {
        if let favorited = favorited {
            if favorited {
                favoriteImage.image = #imageLiteral(resourceName: "favorite")
                self.favorited = false
            } else {
                favoriteImage.image = #imageLiteral(resourceName: "favorite_on")
                self.favorited = true
            }
        } else {
            favoriteImage.image = #imageLiteral(resourceName: "retweet_on")
            self.favorited = true
        }
        
    }
    
    func setRetweeted() {
        if let retweeted = retweeted {
            if retweeted {
                retweetImage.image = #imageLiteral(resourceName: "retweet")
                self.retweeted = false
            } else {
                retweetImage.image = #imageLiteral(resourceName: "retweet_on")
                self.retweeted = true
            }
        } else {
            retweetImage.image = #imageLiteral(resourceName: "retweet_on")
            self.retweeted = true
        }
        
    }

}
