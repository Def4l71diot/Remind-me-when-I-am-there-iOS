//
//  BaseUserAuthManager.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/30/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseUserAuthManager {
    
    func setUser(loggedInUser user: BaseUser)
    
    func getUser() -> BaseUser?
    
    func logout()
    
    func isLoggedIn() -> Bool
}
