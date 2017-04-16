//
//  TweetDetailCell.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/16/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetDate: UILabel!
    
    var tweet: Tweet! {
        didSet {
            name.text = tweet.user?.name as String?
            profileImage.setImageWith(tweet.user?.profileURL! as! URL)
            username.text = "@" + (tweet.user!.screename! as String)
            tweetText.text = tweet.text as String?
            tweetDate.text = getTweetAge(date: tweet.timestamp!)
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
    
    func getTweetAge(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        var dateString = dateFormatter.string(from: date)
        let dateObj = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM/dd/yyyy, h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateString = dateFormatter.string(from: dateObj!)
        return dateString
        
    }

}
