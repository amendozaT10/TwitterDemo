//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Mendoza, Alejandro on 4/11/17.
//  Copyright © 2017 Alejandro Mendoza. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginAction(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: { () -> () in
            print("Login was successful")
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let hamburgerVC = storyBoard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let menuVC = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            let homeNavigationController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationController")
            
            hamburgerVC.menuViewController = menuVC
            hamburgerVC.contentViewController = homeNavigationController
            menuVC.hamburgerViewController = hamburgerVC
        
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            self.present(homeNavigationController, animated: true, completion: nil)
        }, failure: { (error: Error) in
            print("Error \(error.localizedDescription)")
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
