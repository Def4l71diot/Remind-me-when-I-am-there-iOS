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
    
    var dbContext: NSManagedObjectContext{get}
    var entity: NSEntityDescription{get}

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
    
    func getAndQuery() -> String {
        return " AND "
    }
    
    func getOrQuery() -> String {
        return " || "
    }
    
    func getEqualsTrueQuery(forField field: String) -> String {
        return "\(field) == \(NSNumber(booleanLiteral: true))"
    }
    
    func getEqualsFalseQuery(forField field: String) -> String {
        return "\(field) == \(NSNumber(booleanLiteral: false))"
    }
    
    func getEqualsNilQuery(forField field: String) -> String {
        return "\(field) = nil"
    }
}
