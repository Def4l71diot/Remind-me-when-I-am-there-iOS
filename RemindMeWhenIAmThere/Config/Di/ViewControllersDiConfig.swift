//
//  ViewControllersDiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import LocationPicker

class ViewControllersDiConfig {
    public static func setup(_ container: Container) {
        
        container.storyboardInitCompleted(ActiveRemindersTableViewController.self)
        { resolver, controller in
            let localRemindersData = resolver.resolve(BaseLocalRemindersData.self)!
            controller.localRemindersData = localRemindersData
        }
        
        container.storyboardInitCompleted(AddReminderViewController.self)
        { resolver, controller in
            let scheduler = resolver.resolve(BaseScheduler.self)!
            let localRemindersData = resolver.resolve(BaseLocalRemindersData.self)!
            let reminderFactory = resolver.resolve(BaseReminderFactory.self)!
            let userAuthManager = resolver.resolve(BaseUserAuthManager.self)!
            let usersData = resolver.resolve(BaseUsersData.self)!
            
            controller.remindersScheduler = scheduler
            controller.localRemindersData = localRemindersData
            controller.reminderFactory = reminderFactory
            controller.userAuthManager = userAuthManager
            controller.usersData = usersData
            
        }
    }
}
