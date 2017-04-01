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
    typealias T = BaseReminder
    typealias EntityClass = ReminderEntity
}
