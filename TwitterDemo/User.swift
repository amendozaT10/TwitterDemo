//
//  User.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/15/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: NSString?
    var screename: NSString?
    var profileURL: NSURL?
    var backgroundURL: NSURL?
    var tagline: NSString?
    var following: Int?
    var followersCount: Int?
    var tweetsCount: Int?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
       
        print("The iuser info is :")
        print(dictionary)
        print ("END")
        
        name = dictionary["name"] as! NSString?
        screename = dictionary["screen_name"] as! NSString?
        
        let follow = dictionary["following"]
        if let follow = follow as? Int? {
            following = follow
        } else {
            
            following = 0
        }
        
        followersCount = dictionary["followers_count"] as! Int?
        tweetsCount = dictionary["statuses_count"] as! Int?
        
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        let backgroundURLString = dictionary["profile_background_image_url_https"] as? String
        
        
        if let profileUrlString = profileUrlString {
            profileURL = NSURL(string: profileUrlString)
        }
        
        if let backgroundURLString = backgroundURLString {
            backgroundURL = NSURL(string: backgroundURLString)
        }
        
        tagline = dictionary["description"] as! NSString?
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if (_currentUser == nil) {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
