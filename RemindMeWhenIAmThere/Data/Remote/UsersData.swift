//
//  UsersData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

class UsersData: BaseApiData {
    var httpRequester: BaseHttpRequester?
    var apiConfig: BaseApiConfig?
    
    required init(withHttpRequester httpRequester: BaseHttpRequester, andApiConfig apiConfig: BaseApiConfig) {
        self.initAbstractApiData(withHttpRequester: httpRequester, andApiConfig: apiConfig)
    }
    
    func login(user: User, completionHandler: @escaping (User?, String?) -> Void) {
        
        let loginUserUrl = (self.apiConfig?.loginUserUrl)!
        let userDict = user.toDict()
        weak var weakSelf = self
        
        self.httpRequester?.postJson(
            toUrl: loginUserUrl,
            withBody: userDict,
            andHeaders: nil)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            if((response?.statusCode)! >= (weakSelf?.apiConfig?.apiErrorResponseCode)!) {
                let errorMessage = weakSelf?.parseApiErrorMessage(fromJson: responseBody)
                completionHandler(nil, errorMessage)
                return
            }
            
            let userDict = responseBody as! Dictionary<String, Any>
            // TODO: Replace with factory
            let user = User(fromDict: userDict)
            
            completionHandler(user, nil)
        }
        
    }
    
    func register(user: User) {
        
    }
}
