//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/15/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: NSString?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dict: NSDictionary) {
        
        user = User(dictionary: dict["user"] as! NSDictionary)
        text = dict["text"] as? NSString
        retweetCount = (dict["retweet_count"] as? Int) ?? 0
        retweetCount = (dict["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dict["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString) as Date?
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            let tweet = Tweet(dict: dictionary)
            // println(tweet.user?.profileImageUrl)
            tweets.append(tweet)
        }
        
        return tweets
    }
    

}
