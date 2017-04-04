//
//  AccountViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/4/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    let userNotLoggedInErrorMessage = "Your login info is not valid! Please log in again!"
    
    var userAuthManager: BaseUserAuthManager?
    var appDelegate: AppDelegate?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        
        guard let logggedUser = self.userAuthManager?.getUser() else {
            self.showErrorMessage(message: userNotLoggedInErrorMessage)
            { _ in
                weakSelf?.appDelegate?.hasActiveUserSession = false
            }
            return
        }
        
        self.usernameLabel.text = logggedUser.username
        self.userFullNameLabel.text  = logggedUser.firstName
        self.userEmailLabel.text = logggedUser.email
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didRequestLogout() {
        self.userAuthManager?.logout()
        self.appDelegate?.hasActiveUserSession = false
    }

}
