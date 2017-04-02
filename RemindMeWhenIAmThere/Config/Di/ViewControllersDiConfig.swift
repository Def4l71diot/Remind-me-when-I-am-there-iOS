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

class ViewControllersDiConfig {
    public static func setup(_ container: Container) {
        container.storyboardInitCompleted(ActiveRemindersTableViewController.self)
        { resolver, controller in
            let localRemindersData = resolver.resolve(BaseLocalRemindersData.self)!
            controller.localRemindersData = localRemindersData
        }
    }
}
