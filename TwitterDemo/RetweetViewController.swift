//
//  RetweetViewController.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/16/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class RetweetViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var tweet: Tweet?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        

        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetDetailCell", for: indexPath) as! TweetDetailCell
            cell.tweet = tweet
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetStatsCell", for: indexPath) as! TweetStatsCell
            cell.tweet = tweet
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetOption", for: indexPath) as! TweetOption
            
            return cell
        }
    }
    
    @IBAction func onFavorited(_ sender: Any) {
        print("Touched favorite")
        let ip = IndexPath(row: 2, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetOption", for: ip) as! TweetOption
        
        cell.setFavorited()
        
        let params = NSMutableDictionary()
        params.setValue(tweet?.tweetId, forKey: "id")
        
        TwitterClient.sharedInstance?.favorite(params: params, success: { (tweet: Tweet) in
            print("Successfully favorited!")
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        tableView.reloadData()
        
    }

    @IBAction func onRetweet(_ sender: Any) {
        print("Touched retweet")
        let ip = IndexPath(row: 2, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetOption", for: ip) as! TweetOption
        cell.setRetweeted()
        
        
        let id = tweet?.tweetId as String?
        let params = NSMutableDictionary()
        params.setValue(id, forKey: "id")
        
        TwitterClient.sharedInstance?.retweet(id: id, params: params, success: { (tweet: Tweet) in
            print("Successfully retweeted!")
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nc = segue.destination as! UINavigationController
        let tweetVC = nc.viewControllers[0] as! TweetViewController
        //tweetVC.replyId = tweet?.tweetId
        tweetVC.replyId = (tweet?.tweetId)!
        
    }
 

}
