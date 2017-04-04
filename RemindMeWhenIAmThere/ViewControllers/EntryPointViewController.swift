//
//  EntryPointViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/4/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class EntryPointViewController: UIViewController {
    
    var userAuthManager: BaseUserAuthManager?
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //In case we check login with a call to the API
        self.showLoadingIndicator()
        
        let isUserLoggedIn = self.userAuthManager?.isLoggedIn() ?? false
        
        self.appDelegate?.hasActiveUserSession = isUserLoggedIn
        
        self.hideLoadingIndicator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
