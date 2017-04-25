//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/15/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "PYmHXnxgjQ7x2LdlSW9l533sR", consumerSecret: "kYjeOsr5GBDetrrCtmsS0z2y5gZ8HB8d3XNLSHTLtKoDV6ZXzB")

    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            print("I got a access token!")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error?) -> Void in print("error: \(error!.localizedDescription)")
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
            
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("I got a token! \(requestToken!.token!)")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.openURL(url)
            
        }, failure: { (error: Error?) -> Void in print("error: \(error!.localizedDescription)")
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(array: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(array: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func userProfile(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(array: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    
    
    func composeTweet(params: NSMutableDictionary, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let tweet = Tweet(dict: response as! NSDictionary)
            success(tweet)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func retweet(id: String?, params: NSMutableDictionary, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        if let id = id as String! {
            let endpoint = "1.1/statuses/retweet/" + id + ".json"
            post(endpoint, parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
                let tweet = Tweet(dict: response as! NSDictionary)
                success(tweet)
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
            })
        }
    }
    
    func favorite(params: NSMutableDictionary, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let endpoint = "1.1/favorites/create.json"
        
        post(endpoint, parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let tweet = Tweet(dict: response as! NSDictionary)
            success(tweet)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dict = response as! NSDictionary
            let user = User(dictionary: dict)
            success(user)
            
            print ("name: \(user.name)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
            print("Could not call verify credentials")
        })
    }
    
    
}
