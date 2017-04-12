//
//  ReminderManager.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/12/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

class ReminderManager : BaseReminderManager {
    let localRemindersData: BaseLocalRemindersData
    let scheduler: BaseScheduler
    
    init(withLocalRemindersData localRemindersData: BaseLocalRemindersData, andScheduler scheduler: BaseScheduler) {
        self.localRemindersData = localRemindersData
        self.scheduler = scheduler
    }
    
    func setReminder(reminder: BaseReminder) -> Bool {
        
        if let savedReminder = self.localRemindersData.add(reminder) {
            self.scheduler.setReminder(reminder: savedReminder)
            return true
        }
        
        return false
        
    }
    
    func setReminderCompleted(reminder: BaseReminder) {
        reminder.isActive = false
        reminder.isCompleted = true
        _ = self.localRemindersData.update(reminder)
    }
    
    func setReminderCompletedById(id: NSManagedObjectID) {

        let reminder = self.localRemindersData.getById(id: id)
        self.setReminderCompleted(reminder: reminder!)
    }
    
}
