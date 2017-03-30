//
//  UserFactory.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/30/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

class UserFactory: BaseUserFactory {
    
    func getUser(
        withUsername username: String,
        password: String?,
        email: String?,
        firstName: String?,
        authToken: String?,
        andEmailStatus emailStatus: UserEmailStatus?) -> BaseUser {
        
        return User(
            withUsername: username,
            password: password,
            email: email,
            firstName: firstName,
            authToken: authToken,
            andEmailStatus: emailStatus)
    }
    
    func getUser(fromDict dict: Dictionary<String, Any>) -> BaseUser {
        return User(fromDict: dict)
    }
    
    func getLoginUser(withUsername username: String, andPassword password: String) -> BaseUser {
        return User(withLoginUsername: username, andPassword: password)
    }
    
    func getRegisterUser(withUsername username: String, password: String, email: String, andFirstName firstName: String) -> BaseUser {
        return User(withRegisterUsername: username, password: password, email: email, andFirstName: firstName)
    }
    
}
