//
//  BaseLocalRemindersData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

protocol BaseLocalRemindersData: BaseLocalData {
    
    var reminderFactory: BaseReminderFactory{get set}
    
    func add(_ object: BaseReminder) -> Bool
    
    func update(_ object: BaseReminder) -> Bool
    
    func get(withPredicate queryPredicate: NSPredicate?) -> [BaseReminder]
    
    func getAll() -> [BaseReminder]
    
    func getById(id: NSManagedObjectID) -> BaseReminder?
    
    func getByIdAsEntity(id: NSManagedObjectID) -> ReminderEntity?
    
    func getActiveReminders() -> [BaseReminder]
    
    func getActiveGeoReminders() -> [BaseReminder]
}
