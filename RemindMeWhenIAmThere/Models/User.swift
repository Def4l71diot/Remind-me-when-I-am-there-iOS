//
//  User.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

enum UserEmailStatus: String {
    case sent
    case unknown
}

class User {
    var username: String?
    var password: String?
    var email: String?
    var firstName: String?
    var authToken: String?
    var emailStatus: UserEmailStatus?
    
    init(
        withUsername username: String,
        password: String?,
        email: String?,
        firstName: String?,
        authToken: String?,
        andEmailStatus emailStatus: UserEmailStatus?) {
        
        self.username = username
        self.password = password
        self.email = email
        self.firstName = firstName
        self.authToken = authToken
        self.emailStatus = emailStatus
        
    }
    
    convenience init(withRegisterUsername username: String, password: String, email: String, andFirstName firstName: String) {
        self.init(withUsername: username, password: password, email: email, firstName: firstName, authToken: nil, andEmailStatus: nil)
    }
    
    convenience init(withLoginUsername username: String, andPassword password: String) {
        self.init(withUsername: username, password: password, email: nil, firstName: nil, authToken: nil, andEmailStatus: nil)
    }
}
