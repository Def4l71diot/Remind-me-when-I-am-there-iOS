//
//  BaseReminder.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/31/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

protocol BaseReminder: class {
    var id: NSManagedObjectID?{get set}
    var title: String{get set}
    var taskDescription: String{get set}
    var isActive: Bool{get set}
    var isCompleted: Bool{get set}
    
    var remoteId: String?{get set}
    var fromUser: String?{get set}
    var toUser: String?{get set}
    var date: Date?{get set}
    
    var latitude: Double{get set}
    var longitude: Double{get set}
    var locationName: String?{get set}
    
    init(
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
        toUser: String?)
    
}
