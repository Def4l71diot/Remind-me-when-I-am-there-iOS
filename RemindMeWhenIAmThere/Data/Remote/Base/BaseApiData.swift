//
//  BaseApiRequester.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseApiData: class {
    var httpRequester: BaseHttpRequester?{get set}
    var apiConfig: BaseApiConfig?{get set}
    
    init(withHttpRequester httpRequester: BaseHttpRequester, andApiConfig apiConfig: BaseApiConfig)
}

extension BaseApiData {
    func initAbstractApiData(withHttpRequester httpRequester: BaseHttpRequester, andApiConfig apiConfig: BaseApiConfig) {
        self.httpRequester = httpRequester
        self.apiConfig = apiConfig
    }
    
    func parseApiErrorMessage(fromJson json: Any?) -> String {
        let jsonDict = json as? Dictionary<String, Any>
        let errorDictionary = jsonDict?[(self.apiConfig?.apiErrorJsonKey)!] as? Dictionary<String, String>
        
        let message = errorDictionary?[(self.apiConfig?.apiErrorMessageJsonKey)!] ?? "An unknown error occurred"
        
        return message
    }
}


