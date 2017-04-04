//
//  LoginViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/3/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    let usernameNotEmptyErrorMessage = "Username must not be empty"
    let passwordNotEmptyErrorMessage = "Password must not be empty"
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var usersData: BaseUsersData?
    var userFactory: BaseUserFactory?
    var authManager: BaseUserAuthManager?
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        self.showLoadingIndicator()
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        guard username != nil, username != "" else {
            self.showErrorMessage(message: usernameNotEmptyErrorMessage)
            self.hideLoadingIndicator()
            return
        }
        
        guard password != nil, password != "" else {
            self.showErrorMessage(message: passwordNotEmptyErrorMessage)
            self.hideLoadingIndicator()
            return
        }
        
        let loginUser = self.userFactory?.getLoginUser(withUsername: username!, andPassword: password!)
        weak var weakSelf = self
        self.usersData?.login(user: loginUser!)
        { loggedUser, errorMessage in
            
            if errorMessage != nil {
                DispatchQueue.main.async {
                    weakSelf?.hideLoadingIndicator()
                    weakSelf?.showErrorMessage(message: errorMessage!)
                }
                return
            }
            
            weakSelf?.authManager?.setUser(loggedInUser: loggedUser!)
            
            DispatchQueue.main.async {
                weakSelf?.hideLoadingIndicator()
                weakSelf?.appDelegate?.hasActiveUserSession = true
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextFieldTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextFieldTag) as UIResponder!
        
        if(nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }

}
