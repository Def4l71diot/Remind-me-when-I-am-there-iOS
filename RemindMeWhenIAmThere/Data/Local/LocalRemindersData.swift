//
//  LocalRemindersData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

class LocalRemindersData: BaseLocalRemindersData {
    typealias EntityClass = ReminderEntity
    let reminderEntityName = "Reminders"
    var dbContext: NSManagedObjectContext
    var entity: NSEntityDescription
    var reminderFactory: BaseReminderFactory
    
    init(
        withDbContext dbContext: NSManagedObjectContext,
        andReminderFactory reminderFactory: BaseReminderFactory) {
        
        self.dbContext = dbContext
        self.entity = NSEntityDescription.entity(forEntityName: reminderEntityName, in: dbContext)!
        self.reminderFactory = reminderFactory
    }
    
    func add(_ object: BaseReminder) -> BaseReminder? {
        let reminderToAdd =
            EntityClass(
                entity: entity,
                insertInto: dbContext,
                fromReminder: object)
        
        self.dbContext.insert(reminderToAdd)
        if(self.saveChanges()) {
//            let createdReminder = self.getAll().last!
//            return createdReminder
            return reminderToAdd.toBaseReminder(fromReminderFactory: self.reminderFactory)
        } else {
            return nil
        }
        
    }
    
    func update(_ object: BaseReminder) -> Bool {
        if let reminderToUpdate = self.getByIdAsEntity(id: object.id!) {
            reminderToUpdate.changeValues(toMatchReminder: object)
            return self.saveChanges()
        }
        return false
    }
    
    func get(withPredicate queryPredicate: NSPredicate?) -> [BaseReminder] {
        let fetchRequest: NSFetchRequest<EntityClass> = EntityClass.fetchRequest()
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try self.dbContext.fetch(fetchRequest)
            let reminders = response.map(){$0.toBaseReminder(fromReminderFactory: self.reminderFactory)}
            return reminders
        } catch {
            return []
        }
        
    }
    
    func getAll() -> [BaseReminder] {
        return self.get(withPredicate: nil)
    }
    
    func getByIdAsEntity(id: NSManagedObjectID) -> EntityClass? {
        return self.dbContext.object(with: id) as? EntityClass
    }
    
    func getById(id: NSManagedObjectID) -> BaseReminder? {
        return self.getByIdAsEntity(id: id)?.toBaseReminder(fromReminderFactory: self.reminderFactory)
    }
    
    func getActiveReminders() -> [BaseReminder] {
        let isActiveQuery = self.getEqualsTrueQuery(forField: #keyPath(EntityClass.isActive))
        let isNotCompletedQuery = self.getEqualsFalseQuery(forField: #keyPath(EntityClass.isCompleted))
        let isActiveReminderQuery = "(\(isActiveQuery))\(self.getAndQuery())(\(isNotCompletedQuery))"
        let isActiveReminderPredicate = NSPredicate(format: isActiveReminderQuery)
        
        return self.get(withPredicate: isActiveReminderPredicate)
    }
    
    func getActiveGeoReminders() -> [BaseReminder] {
        let isActiveQuery = self.getEqualsTrueQuery(forField: #keyPath(EntityClass.isActive))
        let isNotCompletedQuery = self.getEqualsFalseQuery(forField: #keyPath(EntityClass.isCompleted))
        let isActiveReminderQuery = "(\(isActiveQuery))\(self.getAndQuery())(\(isNotCompletedQuery))"
        
        let isGeoReminderQuery = self.getEqualsNilQuery(forField: #keyPath(EntityClass.dateString))
        let isActiveGeoReminderQuery = "\(isActiveReminderQuery)\(self.getAndQuery())(\(isGeoReminderQuery))"
        let isActiveGeoReminderPredicate = NSPredicate(format: isActiveGeoReminderQuery)
        return self.get(withPredicate: isActiveGeoReminderPredicate)
    }
}
