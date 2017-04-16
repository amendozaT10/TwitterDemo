//
//  TweetStatsCell.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/16/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class TweetStatsCell: UITableViewCell {

    @IBOutlet weak var retweetNumber: UILabel!
    @IBOutlet weak var favoriteAmount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            retweetNumber.text = "\(tweet.retweetCount)"
            favoriteAmount.text = "\(tweet.favoritesCount)"
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

}
