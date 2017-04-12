//
//  BaseReminderManager.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/12/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

protocol BaseReminderManager {
    
    func setReminder(reminder: BaseReminder) -> Bool
    
    func setReminderCompleted(reminder: BaseReminder)
    
    func setReminderCompletedById(id: NSManagedObjectID)
}
