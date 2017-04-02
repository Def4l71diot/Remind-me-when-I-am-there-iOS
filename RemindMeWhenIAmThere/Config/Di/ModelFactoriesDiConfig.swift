//
//  ModelFactoriesDiConfig.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import Swinject

class ModelFactoriesDiConfig {
    public static func setup(_ container: Container) {
        container.register(BaseUserFactory.self){_ in UserFactory()}.inObjectScope(.container)
        container.register(BaseReminderFactory.self){_ in ReminderFactory()}.inObjectScope(.container)
    }
}
