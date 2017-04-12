//
//  Scheduler.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/3/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import CoreLocation

let reminderNotificationDbIdKey = "VL.RMWIT.reminder.objectId"

class Scheduler: BaseScheduler{
    var center = UNUserNotificationCenter.current()
    
    func setReminder(reminder: BaseReminder) {
        weak var weakSelf = self
        self.center.requestAuthorization(options: [.alert, .badge, .sound])
        { (success, error) in
            guard success else { return }
            
            if(reminder.date != nil) {
                
                weakSelf?.createNotificationFromDateReminder(reminder)
            } else {
                weakSelf?.createNotificationFromGeoReminder(reminder)
            }
            
            
        }
    }
    
    func createNotificationFromDateReminder(_ reminder: BaseReminder) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = reminder.title
        notificationContent.subtitle = "It is \(reminder.date!.getLocalDateString())"
        notificationContent.body = reminder.taskDescription
        
        let reminderIdUrlString = reminder.id!.uriRepresentation().absoluteString
        
        notificationContent.userInfo[reminderNotificationDbIdKey] = reminderIdUrlString
        
        notificationContent.sound = UNNotificationSound.default()
        
        notificationContent.categoryIdentifier = reminderNotificationCategoryName
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: reminder.date!)
        let month = calendar.component(.month, from: reminder.date!)
        let day = calendar.component(.day, from: reminder.date!)
        let hour = calendar.component(.hour, from: reminder.date!)
        let minute = calendar.component(.minute, from: reminder.date!)
        
        let date = DateComponents(
            calendar: nil,
            timeZone: nil,
            era: nil,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: nil,
            nanosecond: nil,
            weekday: nil,
            weekdayOrdinal: nil,
            quarter: nil,
            weekOfMonth: nil,
            weekOfYear: nil,
            yearForWeekOfYear: nil)
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let identifier = reminder.id!.uriRepresentation().absoluteString
        
        let notificationRequest =
            UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: notificationTrigger)
        
        
        self.center.add(notificationRequest) { (error) in
            if error != nil {
                print("Unable to add reminder")
            }
        }
    }
    
    func createNotificationFromGeoReminder(_ reminder: BaseReminder) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = reminder.title
        notificationContent.subtitle = "You arrived at \(reminder.date!.getLocalDateString())!"
        notificationContent.body = reminder.taskDescription
        
    }
}
