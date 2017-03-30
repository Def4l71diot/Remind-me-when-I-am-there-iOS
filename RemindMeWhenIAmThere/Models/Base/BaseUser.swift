//
//  BaseUser.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/30/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseUser {
    var username: String?{get set}
    var password: String?{get set}
    var email: String?{get set}
    var firstName: String?{get set}
    var authToken: String?{get set}
    var emailStatus: UserEmailStatus?{get set}
    
    init(
        withUsername username: String,
        password: String?,
        email: String?,
        firstName: String?,
        authToken: String?,
        andEmailStatus emailStatus: UserEmailStatus?)
}
