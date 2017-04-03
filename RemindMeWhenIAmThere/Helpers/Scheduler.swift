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

class Scheduler: BaseScheduler{
    
    func setReminderWithDate(reminderwithDate reminder: BaseReminder) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound])
        { (success, error) in
            guard success else { return }
            
            self.createNotificationFromReminder(reminder)
            
        }
    }
    
    func createNotificationFromReminder(_ reminder: BaseReminder) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = reminder.title
        notificationContent.subtitle = "It is \(reminder.date!.getLocalDateString())"
        notificationContent.body = reminder.taskDescription
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
        
        let notificationRequest =
            UNNotificationRequest(identifier: reminder.title, content: notificationContent, trigger: notificationTrigger)
        
        
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
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
