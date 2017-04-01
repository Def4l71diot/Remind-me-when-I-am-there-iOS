//
//  Reminder.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/31/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

class Reminder: BaseReminder {
    var id: NSManagedObjectID?
    var title: String
    var taskDescription: String
    var isActive: Bool
    var isCompleted: Bool
    
    var remoteId: String?
    var fromUser: String?
    var toUser: String?
    var date: Date?
    
    var longitude: Double
    var latitude: Double
    var locationName: String?
    
    
    required init(
        withId id: NSManagedObjectID?,
        title: String,
        taskDescription: String,
        date: Date?,
        latitude: Double,
        longitude: Double,
        andLocationName locationName: String?,
        isActive: Bool,
        isCompleted: Bool,
        remoteId: String?,
        fromUser: String?,
        toUser: String?) {
        
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
        self.longitude = longitude
        self.latitude = latitude
        self.locationName = locationName
        self.isActive = isActive
        self.isCompleted = isCompleted
        self.remoteId = remoteId
        self.fromUser = fromUser
        self.toUser = toUser
    }
    
    convenience init(
        withTitle title: String,
        taskDescription: String,
        forDate date: Date,
        isActive: Bool,
        isCompleted: Bool,
        fromUser: String?,
        toUser: String?) {
        
        self.init(
            withId: nil,
            title: title,
            taskDescription: taskDescription,
            date: date,
            latitude: 0,
            longitude: 0,
            andLocationName: nil,
            isActive: isActive,
            isCompleted: isCompleted,
            remoteId: nil,
            fromUser: fromUser,
            toUser: toUser)
    }
    
    convenience init(
         withTitle title: String,
         taskDescription: String,
         latitude: Double,
         longitude: Double,
         andLocationName locationName: String?,
         isActive: Bool,
         isCompleted: Bool,
         fromUser: String?,
         toUser: String?) {
        
        
        self.init(
            withId: nil,
            title: title,
            taskDescription: taskDescription,
            date: nil,
            latitude: latitude,
            longitude: longitude,
            andLocationName: locationName,
            isActive: isActive,
            isCompleted: isCompleted,
            remoteId: nil,
            fromUser: fromUser,
            toUser: toUser)
    }
    
}
