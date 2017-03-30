//
//  UserAuthManager.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/30/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

class UserAuthManager: BaseUserAuthManager {
    let userDefaultsUserNameKey = "username"
    let userDefaultsFirstNameKey = "firstName"
    let userDefaultsEmailKey = "email"
    let userDefaultsAuthTokenKey = "authToken"
    var userDefaults: UserDefaults
    var userFactory: BaseUserFactory
    
    init(withUserFactory userFactory: BaseUserFactory) {
        self.userDefaults = UserDefaults.standard
        self.userFactory = userFactory
    }
    
    func setUser(loggedInUser user: BaseUser) {
        self.userDefaults.set(user.username!, forKey: userDefaultsUserNameKey)
        self.userDefaults.set(user.firstName!, forKey: userDefaultsFirstNameKey)
        self.userDefaults.set(user.email!, forKey: userDefaultsEmailKey)
        self.userDefaults.set(user.authToken!, forKey: userDefaultsAuthTokenKey)
    }
    
    func getUser() -> BaseUser? {
        let username =  self.userDefaults.string(forKey: userDefaultsUserNameKey)
        let firstName =  self.userDefaults.string(forKey: userDefaultsFirstNameKey)
        let email =  self.userDefaults.string(forKey: userDefaultsEmailKey)
        let authToken =  self.userDefaults.string(forKey: userDefaultsAuthTokenKey)
        
        if username != nil, firstName != nil, email != nil, authToken != nil {
            let user = self.userFactory.getUser(
                withUsername: username!,
                password: nil,
                email: email!,
                firstName: firstName!,
                authToken: authToken!,
                andEmailStatus: nil)
            
            return user
        } else {
            return nil
        }
    }
    
    func logout() {
        self.userDefaults.removeObject(forKey: userDefaultsUserNameKey)
        self.userDefaults.removeObject(forKey: userDefaultsFirstNameKey)
        self.userDefaults.removeObject(forKey: userDefaultsEmailKey)
        self.userDefaults.removeObject(forKey: userDefaultsAuthTokenKey)
    }
    
    func isLoggedIn() -> Bool {
        return self.getUser() != nil
    }
}
