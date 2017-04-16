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
    @IBOutlet weak var replyField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User.currentUser
        
        let defaultProfileUrl = URL(string: "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")
        
        if (user?.profileURL as URL!) != defaultProfileUrl {
            profileImage.setImageWith((user?.profileURL)! as URL)
        } else {
            profileImage.image = #imageLiteral(resourceName: "Twitter_logo_blue")
        }
        
        name.text = user?.name as String?
        userName.text = "@" + (user?.screename as String!)

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
