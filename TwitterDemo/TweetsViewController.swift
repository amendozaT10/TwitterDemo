//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/15/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 50/255, green: 207/255, blue: 255/255, alpha: 1.0)
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            
        })
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (refreshControlAction(refreshControl:) ), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: refresh func
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tweetsTableView.reloadData()
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        }, failure: { (error: Error) in
        })
    }

    // MARK: table view funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    //MATK: system funcs
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("Performing segue")
        
        if let cell = sender as? UITableViewCell {
            let indexPath = tweetsTableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let retweetVC = segue.destination as! RetweetViewController
            retweetVC.tweet = tweet
        }
        
    }
    

}
