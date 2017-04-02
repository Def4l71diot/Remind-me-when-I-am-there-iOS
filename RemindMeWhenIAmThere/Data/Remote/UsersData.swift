//
//  UsersData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

class UsersData: BaseUsersData, BaseApiData {
    let emailJsonKey = "email"
    
    var httpRequester: BaseHttpRequester
    var apiConfig: BaseApiConfig
    var userFactory: BaseUserFactory
    
    init(
        withHttpRequester httpRequester: BaseHttpRequester,
        apiConfig: BaseApiConfig,
        andUserFactory userFactory: BaseUserFactory) {
        
        self.httpRequester = httpRequester
        self.apiConfig = apiConfig
        self.userFactory = userFactory
    }
    
    func login(user: BaseUser, completionHandler: @escaping (BaseUser?, String?) -> Void) {
        
        let loginUserUrl = self.apiConfig.loginUserUrl
        let userDict = user.toDict()
        weak var weakSelf = self
        
        self.httpRequester.postJson(
            toUrl: loginUserUrl,
            withBody: userDict,
            andHeaders: nil)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler(nil, errorMessage)
                return
            }
            
            let userDict = responseBody as! Dictionary<String, Any>

            let user = weakSelf?.userFactory.getUser(fromDict: userDict)
            
            completionHandler(user, nil)
        }
        
    }
    
    func register(user: BaseUser, completionHandler: @escaping (BaseUser?, String?) -> Void) {
        let registerUserUrl = self.apiConfig.registerUserUrl
        let userDict = user.toDict()
        weak var weakSelf = self
        
        self.httpRequester.postJson(
            toUrl: registerUserUrl,
            withBody: userDict,
            andHeaders: nil)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler(nil, errorMessage)
                return
            }
            
            let userDict = responseBody as! Dictionary<String, Any>
            
            let createdUser = weakSelf?.userFactory.getUser(fromDict: userDict)
            
            completionHandler(createdUser, nil)
            
        }
        
    }
    
    func resetPassword(forEmail email: String, completionHandler: @escaping (Bool, String?) -> Void) {
        let passwordResetUrl = self.apiConfig.passwordResetUrl
        let emailDict = [
            emailJsonKey : email
        ]
        
        weak var weakSelf = self
        
        self.httpRequester.postJson(
            toUrl: passwordResetUrl,
            withBody: emailDict,
            andHeaders: nil)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(false, error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler(false, errorMessage)
            } else if((response?.statusCode)! == (weakSelf?.apiConfig.apiSuccessResponseCode)!) {
                completionHandler(true, nil)
            } else {
                completionHandler(false, (weakSelf?.apiConfig.apiUnkwonErrorMessage)!)
            }
        }
        
    }
    
    func searchUsers(
        withNameContaining partialName: String,
        authToken: String,
        completionHandler: @escaping ([BaseUser], String?) -> Void) {
        
        let searchUsersUrl = self.apiConfig.getSearchUsersUrl(forPartialName: partialName)
        let apiAuthHeaderKey = self.apiConfig.apiAuthHeaderKey
        let headers = [
            apiAuthHeaderKey : authToken
        ]
        
        weak var weakSelf = self
        
        self.httpRequester.getJson(
            toUrl: searchUsersUrl,
            withHeaders: headers)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler([], error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler([], errorMessage)
                return
            }
            
            let usersDictArray = responseBody as? [Dictionary<String, Any>]
            var users: [BaseUser] = []
            usersDictArray?.forEach() {users.append((weakSelf?.userFactory.getUser(fromDict: $0))!)}
            
            completionHandler(users, nil)
        }
        
    }
    
    func getBuddies(withAuthToken authToken: String, completionHandler: @escaping ([String], String?) -> Void) {
        let myBuddiesUrl = apiConfig.getMyBuddiesUrl
        let apiAuthHeaderKey = self.apiConfig.apiAuthHeaderKey
        let headers = [
            apiAuthHeaderKey : authToken
        ]
        
        weak var weakSelf = self
        
        self.httpRequester.getJson(
            toUrl: myBuddiesUrl,
            withHeaders: headers)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler([], error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler([], errorMessage)
                return
            }
            
            let buddyUsernames = responseBody as? [String] ?? []
            completionHandler(buddyUsernames, nil)
            
        }
    }
}
