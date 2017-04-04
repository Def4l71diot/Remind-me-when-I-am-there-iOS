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
        
        container.storyboardInitCompleted(RegisterViewController.self)
        { resolver, controller in
            let usersData = resolver.resolve(BaseUsersData.self)
            let userFactory = resolver.resolve(BaseUserFactory.self)
            
            controller.usersData = usersData
            controller.userFactory = userFactory
            
        }
        
        container.storyboardInitCompleted(LoginViewController.self)
        { resolver, controller in
            let appDelegate = resolver.resolve(AppDelegate.self)
            let usersData = resolver.resolve(BaseUsersData.self)
            let userFactory = resolver.resolve(BaseUserFactory.self)
            let userAuthManager = resolver.resolve(BaseUserAuthManager.self)
            
            controller.appDelegate = appDelegate
            controller.usersData = usersData
            controller.userFactory = userFactory
            controller.authManager = userAuthManager
        }
        
        container.storyboardInitCompleted(EntryPointViewController.self)
        { resolver, controller in
            let appDelegate = resolver.resolve(AppDelegate.self)
            let userAuthManager = resolver.resolve(BaseUserAuthManager.self)
            
            controller.appDelegate = appDelegate
            controller.userAuthManager = userAuthManager
        }
        
        container.storyboardInitCompleted(AccountViewController.self)
        { resolver, controller in
            let appDelegate = resolver.resolve(AppDelegate.self)
            let userAuthManager = resolver.resolve(BaseUserAuthManager.self)
            
            controller.appDelegate = appDelegate
            controller.userAuthManager = userAuthManager
        }
    }
}
