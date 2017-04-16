//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/15/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var tweetName: UILabel!
    @IBOutlet weak var tweetUsername: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetAge: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetName.text = tweet.user?.name as String?
            thumbImageView.setImageWith(tweet.user?.profileURL! as! URL)
            tweetUsername.text = "@" + (tweet.user!.screename! as String)
            tweetText.text = tweet.text as String?
            tweetAge.text = getTweetAge(date: tweet.timestamp!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 5
        thumbImageView.clipsToBounds = true
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateString = dateFormatter.string(from: dateObj!)
        return dateString
        
    }

}
