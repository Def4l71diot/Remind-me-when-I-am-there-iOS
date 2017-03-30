//
//  BaseUsersData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/31/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseUsersData {
    
    func login(user: BaseUser, completionHandler: @escaping (BaseUser?, String?) -> Void)
    
    func register(user: BaseUser, completionHandler: @escaping (BaseUser?, String?) -> Void)
    
    func resetPassword(forEmail email: String, completionHandler: @escaping (Bool, String?) -> Void)
    
    func searchUsers(
        withNameContaining partialName: String,
        authToken: String,
        completionHandler: @escaping ([BaseUser], String?) -> Void)
}
