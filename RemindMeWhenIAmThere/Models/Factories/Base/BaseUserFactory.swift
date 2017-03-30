//
//  BaseUserFactory.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/30/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseUserFactory {
    
    func getUser(
        withUsername username: String,
        password: String?,
        email: String?,
        firstName: String?,
        authToken: String?,
        andEmailStatus emailStatus: UserEmailStatus?) -> BaseUser
    
    func getUser(fromDict dict: Dictionary<String, Any>) -> BaseUser
    
    func getLoginUser(withUsername username: String, andPassword password: String) -> BaseUser
    
    func getRegisterUser(withUsername username: String, password: String, email: String, andFirstName firstName: String) -> BaseUser
}
