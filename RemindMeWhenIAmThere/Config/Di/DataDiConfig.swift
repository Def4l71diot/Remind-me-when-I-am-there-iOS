//
//  DataDiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import Swinject
import CoreData

class LocalDataDiConfig {
    public static func setup(_ container: Container) {
        container.register(BaseLocalRemindersData.self)
        { resolver in
            let dbContext = resolver.resolve(NSManagedObjectContext.self)!
            let reminderFactory = resolver.resolve(BaseReminderFactory.self)!
            
            let localRemindersData =
                LocalRemindersData(
                    withDbContext: dbContext,
                    andReminderFactory: reminderFactory)
            
            return localRemindersData
        }.inObjectScope(.container)
        
    }
}

class RemoteDataDiConfig {
    public static func setup(_ container: Container) {
        container.register(BaseApiConfig.self){_ in ApiConfig()}
        
        container.register(BaseUsersData.self)
        { resolver in
            let httpRequester = resolver.resolve(BaseHttpRequester.self)!
            let apiConfig = resolver.resolve(BaseApiConfig.self)!
            let userFactory = resolver.resolve(BaseUserFactory.self)!
            
            let usersData =
                UsersData(
                    withHttpRequester: httpRequester,
                    apiConfig: apiConfig,
                    andUserFactory: userFactory)
            
            return usersData
        }
    }
}
