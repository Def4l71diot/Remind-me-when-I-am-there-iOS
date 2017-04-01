//
//  ReminderEntityExtension.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

extension ReminderEntity {
    convenience init(
        entity: NSEntityDescription,
        insertInto context: NSManagedObjectContext?,
        withTitle title: String,
        taskDescription: String,
        date: Date?,
        latitude: Double,
        longitude: Double,
        andLocationName locationName: String?,
        isActive: Bool,
        isCompleted: Bool,
        remoteId: String?,
        fromUser: String?) {
        
        self.init(entity: entity, insertInto: context)
        
        self.title = title
        self.taskDecription = taskDescription
        self.dateString = date?.getLocalDateString()
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
        self.isActive = isActive
        self.isCompleted = isCompleted
        self.remoteId = remoteId
        self.fromUser = fromUser
        
    }
    
    convenience init(
        entity: NSEntityDescription,
        insertInto context: NSManagedObjectContext?,
        fromReminder reminder: BaseReminder) {
        
        self.init(entity: entity, insertInto: context)
        self.changeValues(toMatchReminder: reminder)
    }
    
    func changeValues(toMatchReminder reminder: BaseReminder) {
        self.title = reminder.title
        self.taskDecription = reminder.taskDescription
        self.dateString = reminder.date?.getLocalDateString()
        self.latitude = reminder.latitude
        self.longitude = reminder.longitude
        self.locationName = reminder.locationName
        self.isActive = reminder.isActive
        self.isCompleted = reminder.isCompleted
        self.remoteId = reminder.remoteId
        self.fromUser = reminder.fromUser
        
    }
    
    func toBaseReminder(fromReminderFactory reminderFactory: BaseReminderFactory) -> BaseReminder {
        return reminderFactory
                .getReminder(
                    withId: self.objectID,
                    title: self.title!,
                    taskDescription: self.taskDecription!,
                    date: self.dateString?.getAsDate(),
                    latitude: self.latitude,
                    longitude: self.longitude,
                    andLocationName: self.locationName,
                    isActive: self.isActive,
                    isCompleted: self.isCompleted,
                    remoteId: self.remoteId,
                    fromUser: self.fromUser,
                    toUser: nil)
    }
}
