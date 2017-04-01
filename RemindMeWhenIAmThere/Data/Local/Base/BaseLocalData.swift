//
//  BaseLocalData.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation
import CoreData

protocol BaseLocalData {
    associatedtype T
    associatedtype EntityClass
    
    var dbContext: NSManagedObjectContext{get}
    var entity: NSEntityDescription{get}
    
    func add(_ object: T) -> Bool
    
    func update(_ object: T) -> Bool
    
    func get(withPredicate queryPredicate: NSPredicate?) -> [T]
    
    func getAll() -> [T]
    
    func getById(id: NSManagedObjectID) -> T
    
    func getByIdAsEntity(id: NSManagedObjectID) -> EntityClass
}

extension BaseLocalData {
    func saveChanges() -> Bool {
        do {
            try self.dbContext.save()
            return true
        } catch {
            return false
        }
    }
}
