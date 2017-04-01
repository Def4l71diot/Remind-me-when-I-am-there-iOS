//
//  ReminderFactory.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

class ReminderFactory: BaseReminderFactory {
    func getReminder(
        withId id: NSManagedObjectID?,
        title: String,
        taskDescription: String,
        date: Date?,
        latitude: Double,
        longitude: Double,
        andLocationName
        locationName: String?,
        isActive: Bool,
        isCompleted: Bool,
        remoteId: String?,
        fromUser: String?,
        toUser: String?) -> BaseReminder {
        
        return Reminder(
            withId: id,
            title: title,
            taskDescription: taskDescription,
            date: date,
            latitude: latitude,
            longitude: longitude,
            andLocationName: locationName,
            isActive: isActive,
            isCompleted: isCompleted,
            remoteId: remoteId,
            fromUser: fromUser,
            toUser: toUser)
    }
    
    func getLocalReminder(
        withTitle title: String,
        andTaskDescription taskDescription: String,
        forDate date: Date) -> BaseReminder {
        
        return Reminder(
            withTitle: title,
            taskDescription: taskDescription,
            forDate: date,
            isActive: true,
            isCompleted: false,
            fromUser: nil,
            toUser: nil)
    }
    
    func getLocalReminder(
        withTitle title: String,
        taskDescription: String,
        latitude: Double,
        longitude: Double,
        andLocationName locationName: String) -> BaseReminder {
        
        return Reminder(
            withTitle: title,
            taskDescription: taskDescription,
            latitude: latitude,
            longitude: longitude,
            andLocationName: locationName,
            isActive: true,
            isCompleted: false,
            fromUser: nil,
            toUser: nil)
    }
    
    func getRemoteReminder(
        withTitle title: String,
        andTaskDescription taskDescription: String,
        forDate date: Date,
        forUser user: String) -> BaseReminder {
        
        return Reminder(
            withTitle: title,
            taskDescription: taskDescription,
            forDate: date,
            isActive: false,
            isCompleted: false,
            fromUser: nil,
            toUser: user)
    }
    
    func getRemoteReminder(
        withTitle title: String,
        taskDescription: String,
        latitude: Double,
        longitude: Double,
        andLocationName locationName: String,
        forUser user: String) -> BaseReminder {
        
        return Reminder(
            withTitle: title,
            taskDescription: taskDescription,
            latitude: latitude,
            longitude: longitude,
            andLocationName: locationName,
            isActive: false,
            isCompleted: false,
            fromUser: nil,
            toUser: user)
    }
}
