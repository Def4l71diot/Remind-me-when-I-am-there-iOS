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
    let reminderEntityName = "Reminders"
    var dbContext: NSManagedObjectContext
    var entity: NSEntityDescription
    
    init(withDbContext dbContext: NSManagedObjectContext) {
        self.dbContext = dbContext
        self.entity = NSEntityDescription.entity(forEntityName: reminderEntityName, in: dbContext)!
    }
    
    func add(_ object: BaseReminder) -> Bool {
        let reminderToAdd =
            EntityClass(
                entity: entity,
                insertInto: dbContext,
                fromReminder: object)
        
        self.dbContext.insert(reminderToAdd)
        return self.saveChanges()
        
    }
    
    func update(_ object: BaseReminder) -> Bool {
        let reminderToUpdate = self.getByIdAsEntity(id: object.id!)
        reminderToUpdate.changeValues(toMatchReminder: object)
        return self.saveChanges()
    }
    
    func get(withPredicate queryPredicate: NSPredicate?) -> [BaseReminder] {
        let fetchRequest: NSFetchRequest<EntityClass> = EntityClass.fetchRequest()
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try self.dbContext.fetch(fetchRequest)
            let reminders = response.map(){$0.toBaseReminder()}
            return reminders
        } catch {
            return []
        }
        
    }
    
    func getAll() -> [BaseReminder] {
        return self.get(withPredicate: nil)
    }
    
    func getByIdAsEntity(id: NSManagedObjectID) -> ReminderEntity {
        return self.dbContext.object(with: id) as! EntityClass
    }
    
    func getById(id: NSManagedObjectID) -> BaseReminder {
        return self.getByIdAsEntity(id: id).toBaseReminder()
    }
}
