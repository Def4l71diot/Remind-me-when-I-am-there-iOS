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
}
