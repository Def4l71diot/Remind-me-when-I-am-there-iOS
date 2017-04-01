//
//  MainViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/27/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var usersData: BaseUsersData?
    var userAuthManager: BaseUserAuthManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonParser = JsonParser()
        let apiConfig = ApiConfig()
        let userFactory = UserFactory()
        self.userAuthManager = UserAuthManager(withUserFactory: userFactory)
        let httpRequester = HttpRequester(withJsonParser: jsonParser)
        self.usersData = UsersData(withHttpRequester: httpRequester, apiConfig: apiConfig, andUserFactory: userFactory)
        
        let user = userFactory.getLoginUser(withUsername: "Pesho69", andPassword: "123456")
        
        weak var weakSelf = self
        
        if((self.userAuthManager?.isLoggedIn())!) {
            let localUser = self.userAuthManager?.getUser()
            self.usersData?.searchUsers(withNameContaining: "k", authToken: localUser!.authToken!)
            { users, errorMessage in
                if(errorMessage != nil) {
                    print("ERROR SEARCHING: \(errorMessage!)")
                    return
                }
                
                users.forEach() {
                    print("\($0.username!) (\($0.firstName!))")
                }
            }
        }
        
        
        //        self.usersData?.login(user: user)
        //        { loggedInUser, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR: \(errorMessage!)")
        //                return
        //            }
        //
        //            print("Username: \((loggedInUser?.username)!) FirstName: \((loggedInUser?.firstName)!) AuthToken: \((loggedInUser?.authToken)!) Email: \((loggedInUser?.email)!)")
        //
        //            weakSelf?.userAuthManager?.setUser(loggedInUser: loggedInUser!)
        //
        //            let currentUser = weakSelf?.userAuthManager?.getUser()
        //            let a = 5
        //        }
        //
        //        let registerUser = userFactory.getRegisterUser(withUsername: "Talanta", password: "123456", email: "teamvinkel23@mail.bg", andFirstName: "Toteto")
        //        self.usersData?.register(user: registerUser)
        //        { registeredUser, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR CREATING: \(errorMessage!)")
        //                return
        //            }
        //
        //            let user = registeredUser!
        //            let b = 5
        //
        //        }
        
        //        self.usersData?.resetPassword(forEmail: "teamvinkel23@mail.bg")
        //        { sentResetEmailSuccessfuly, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR RESETTING: \(errorMessage!)")
        //                return
        //            }
        //
        //            print(sentResetEmailSuccessfuly)
        //        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
