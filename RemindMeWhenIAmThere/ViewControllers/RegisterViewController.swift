//
//  RegisterViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/3/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    let invalidFullNameMessage = "The full name you entered is not valid"
    let invalidUsernameMessage = "Invalid username!"
    let invalidEmailMessage = "The email is not valid"
    let invalidPasswordMessage = "Your password is too short!"
    let minCharactersForField = 3
    
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    var usersData: BaseUsersData?
    var userFactory: BaseUserFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.fullNameTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submit(_ sender: Any) {
        self.showLoadingIndicator()
        let username = self.usernameTextField.text
        let email = self.emailTextField.text
        let fullName = self.fullNameTextField.text
        let password = self.passwordTextField.text
        
        guard username != nil, (username?.characters.count)! >= minCharactersForField else {
            self.showErrorMessage(message: invalidUsernameMessage)
            self.hideLoadingIndicator()
            return
        }
        
        guard email != nil, (email?.contains("@"))!, (email?.characters.count)! >= minCharactersForField else {
            self.showErrorMessage(message: invalidEmailMessage)
            self.hideLoadingIndicator()
            return
        }
        
        guard fullName != nil, (fullName?.characters.count)! >= minCharactersForField else {
            self.showErrorMessage(message: invalidFullNameMessage)
            self.hideLoadingIndicator()
            return
        }
        
        guard password != nil, (password?.characters.count)! >= minCharactersForField else {
            self.showErrorMessage(message: invalidPasswordMessage)
            self.hideLoadingIndicator()
            return
        }
        let userToRegister = self.userFactory?
            .getRegisterUser(withUsername: username!, password: password!, email: email!, andFirstName: fullName!)
        
        weak var weakSelf = self
        self.usersData?.register(user: userToRegister!)
        { result, errorMessage in
            if(errorMessage != nil) {
                DispatchQueue.main.async {
                    weakSelf?.hideLoadingIndicator()
                    weakSelf?.showErrorMessage(message: errorMessage!)
                    return
                }
            }
            DispatchQueue.main.async {
                weakSelf?.hideLoadingIndicator()
                _ = weakSelf?.navigationController?.popViewController(animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
