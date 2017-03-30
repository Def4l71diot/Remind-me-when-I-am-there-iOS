//
//  ApiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

class ApiConfig: BaseApiConfig {
    var baseUrl = "http://192.168.1.96:3001"
    
    var registerUserUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/register")
        }
    }
    
    var loginUserUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/login")
        }
    }
    
    var passwordResetUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/reset-password")
        }
    }
    
    var sendBuddyRequestUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/send-buddy-request")
        }
    }
    
    var confirmBuddyRequestUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/confirm-buddy-request")
        }
    }
    
    var checkStatusBetweenUsersUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/check-status-between-users")
        }
    }
    
    var getMyBuddiesUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/my-buddies")
        }
    }
    
    var getMyBuddyRequestsUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/my-buddy-requests")
        }
    }
    
    var createReminderForBuddyUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/create-reminder-for-buddy")
        }
    }
    
    var getMyRemindersUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/my-reminders")
        }
    }
    
    var getMyPendingRemindersUrl: String {
        get {
            return self.getBaseUrl(withSuffix: "/my-pending-reminders")
        }
    }
    
    var apiAuthHeaderKey = "auth-token"
    var apiErrorResponseCode = 400
    var apiErrorJsonKey = "error"
    var apiErrorMessageJsonKey = "message"
    
    func getSearchUsersUrl(forPartialName partialName: String) -> String {
        let searchUsersUrlSuffix = "/search-users/\(partialName)"
        return self.getBaseUrl(withSuffix: searchUsersUrlSuffix)
    }
    
    func getGetReminderByIdUrl(id: String) -> String {
        let getReminderByIdUrlSuffix = "/search-users/\(id)"
        return self.getBaseUrl(withSuffix: getReminderByIdUrlSuffix)
    }
    
    func getAcceptReminderUrl(forReminderWithId id: String) -> String {
        let acceptReminderUrlSuffix = "/accept-reminder/\(id)"
        return self.getBaseUrl(withSuffix: acceptReminderUrlSuffix)
    }
    
    func getBaseUrl(withSuffix suffix: String) -> String {
        return "\(self.baseUrl)\(suffix)"
    }
}
