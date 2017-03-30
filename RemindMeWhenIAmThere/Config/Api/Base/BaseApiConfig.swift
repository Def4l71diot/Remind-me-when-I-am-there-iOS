//
//  BaseApiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseApiConfig {
    var baseUrl: String{get}
    var registerUserUrl: String{get}
    var loginUserUrl: String{get}
    var passwordResetUrl: String{get}
    
    var sendBuddyRequestUrl: String{get}
    var confirmBuddyRequestUrl: String{get}
    var checkStatusBetweenUsersUrl: String{get}
    var getMyBuddiesUrl: String{get}
    var getMyBuddyRequestsUrl: String{get}
    
    var createReminderForBuddyUrl: String{get}
    var getMyRemindersUrl: String{get}
    var getMyPendingRemindersUrl: String{get}
    
    var apiAuthHeaderKey: String{get}
    var apiSuccessResponseCode: Int{get}
    var apiErrorResponseCode: Int{get}
    var apiErrorJsonKey: String{get}
    var apiErrorMessageJsonKey: String{get}
    var apiUnkwonErrorMessage: String{get}
    
    func getSearchUsersUrl(forPartialName partialName: String) -> String
    
    func getGetReminderByIdUrl(id: String) -> String
    func getAcceptReminderUrl(forReminderWithId id: String) -> String
    
}
