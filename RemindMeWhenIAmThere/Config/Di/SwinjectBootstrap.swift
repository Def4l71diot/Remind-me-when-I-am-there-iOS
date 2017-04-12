//
//  SwinjectBootstrap.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    public static func setup() {
        Container.loggingFunction = nil
        
        defaultContainer.register(AppDelegate.self){_ in return UIApplication.shared.delegate as! AppDelegate}
        
        defaultContainer.register(NSManagedObjectContext.self)
        { resolver in
            let appDelegate = resolver.resolve(AppDelegate.self)!
            return appDelegate.persistentContainer.viewContext
        }
        
        ModelFactoriesDiConfig.setup(defaultContainer)
        
        
        LocalDataDiConfig.setup(defaultContainer)
        
        HelpersDiConfig.setup(defaultContainer)
        
        RemoteDataDiConfig.setup(defaultContainer)
        
        ViewControllersDiConfig.setup(defaultContainer)
    }
    
    static func getReminderManager() -> BaseReminderManager {
        return defaultContainer.resolve(BaseReminderManager.self)!
    }
}
