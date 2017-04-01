//
//  BaseReminderFactory.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

protocol BaseReminderFactory {
    
    func getReminder(
        withId id: NSManagedObjectID?,
        title: String,
        taskDescription: String,
        date: Date?,
        longitude: Double,
        latitude: Double,
        andLocationName locationName: String?,
        isActive: Bool,
        isCompleted: Bool,
        remoteId: String?,
        fromUser: String?,
        toUser: String?) -> BaseReminder
    
    func getLocalReminder(
        withTitle title: String,
        andTaskDescription taskDescription: String,
        forDate date: Date) -> BaseReminder
    
    func getLocalReminder(
        withTitle title: String,
        taskDescription: String,
        longitude: Double,
        latitude: Double,
        andLocationName locationName: String) -> BaseReminder
    
    func getRemoteReminder(
        withTitle title: String,
        andTaskDescription taskDescription: String,
        forDate date: Date,
        forUser user: String) -> BaseReminder
    
    func getRemoteReminder(
        withTitle title: String,
        taskDescription: String,
        longitude: Double,
        latitude: Double,
        andLocationName locationName: String,
        forUser user: String) -> BaseReminder
}
