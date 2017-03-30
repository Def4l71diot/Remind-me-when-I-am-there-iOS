//
//  UserDictExtension.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

extension User {
    fileprivate static func getUsernameKeyForDict() -> String {
        return "username"
    }
    
    fileprivate static func getPasswordKeyForDict() -> String {
        return "password"
    }
    
    fileprivate static func getEmailKeyForDict() -> String {
        return "email"
    }
    
    fileprivate static func getFirstNameKeyForDict() -> String {
        return "first_name"
    }
    
    fileprivate static func getAuthTokenKeyForDict() -> String {
        return "authtoken"
    }
    
    fileprivate static func getEmailStatusKeyForDict() -> String {
        return "email_status"
    }
    
    convenience init(fromDict dict: Dictionary<String, Any>) {
        let username = dict[User.getUsernameKeyForDict()] as! String
        let email = dict[User.getEmailKeyForDict()] as? String
        let firstName = dict[User.getFirstNameKeyForDict()] as! String
        let authToken = dict[User.getAuthTokenKeyForDict()] as? String
        let emailStatusString = dict[User.getEmailStatusKeyForDict()] as? String
        let emailStatus = emailStatusString != nil ? UserEmailStatus(rawValue: emailStatusString!) : nil
        
        self.init(withUsername: username, password: nil, email: email, firstName: firstName, authToken: authToken, andEmailStatus: emailStatus)
    }
    
    func toDict() -> Dictionary<String, Any> {
        var userDict: Dictionary<String, Any> = [:]
        userDict[User.getUsernameKeyForDict()] = self.username!
        
        if(self.password != nil) {
            userDict[User.getPasswordKeyForDict()] = self.password!
        }
        
        if(self.email != nil) {
            userDict[User.getEmailKeyForDict()] = self.email!
        }
        
        if(self.firstName != nil) {
            userDict[User.getFirstNameKeyForDict()] = self.firstName!
        }
        
        
        return userDict
    }
}
