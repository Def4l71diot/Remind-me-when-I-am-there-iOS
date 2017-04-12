//
//  HelpersDiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import Swinject

class HelpersDiConfig {
    public static func setup(_ container: Container) {
        container.register(BaseJsonParser.self){_ in JsonParser()}
        
        container.register(BaseHttpRequester.self)
        { resolver in
            let jsonParser = resolver.resolve(BaseJsonParser.self)!
            let httpRequester = HttpRequester(withJsonParser: jsonParser)
            return httpRequester
        }.inObjectScope(.container)
        
        container.register(BaseUserAuthManager.self)
        { resolver in
            let userFactory = resolver.resolve(BaseUserFactory.self)!
            let userAuthManager = UserAuthManager(withUserFactory: userFactory)
            return userAuthManager
        }.inObjectScope(.container)
        
        container.register(BaseScheduler.self) {_ in Scheduler()}.inObjectScope(.container)
        
        container.register(BaseReminderManager.self)
        { resolver in
            let localRemindersData = resolver.resolve(BaseLocalRemindersData.self)!
            let scheduler = resolver.resolve(BaseScheduler.self)!
            
            let reminderManager =
                ReminderManager(withLocalRemindersData: localRemindersData, andScheduler: scheduler)
            
            return reminderManager
        }.inObjectScope(.container)
    }
}
