//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/16/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var replyTextField: UITextView!
    
    var replyId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 50/255, green: 207/255, blue: 255/255, alpha: 1.0)
        
        let user = User.currentUser
        
        let defaultProfileUrl = URL(string: "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")
        
        if (user?.profileURL as URL!) != defaultProfileUrl {
            profileImage.setImageWith((user?.profileURL)! as URL)
        } else {
            profileImage.image = #imageLiteral(resourceName: "Twitter_logo_blue")
        }
        
        name.text = user?.name as String?
        userName.text = "@" + (user?.screename as String!)
        
        replyTextField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: Any) {
        let params = NSMutableDictionary()
        if (replyId != "") {
            params.setValue(replyId, forKey: "in_reply_to_status_id")
        }
        params.setValue(replyTextField.text, forKey: "status")
        
        TwitterClient.sharedInstance?.composeTweet(params: params, success: { (tweet: Tweet) in
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
