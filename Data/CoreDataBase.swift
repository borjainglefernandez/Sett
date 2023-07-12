//
//  CoreDataBase.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/27/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataBase {
    
    // Context to interact with CoreData
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static public func executeFetchRequest<T>( expecting expectedReturnType: T.Type, with fetchRequest: NSFetchRequest<T>) -> [T]? {
        do {
            let result = try self.context.fetch(fetchRequest)
            return result
        } catch {
            print("Error executing fetch request: \(error)")
            return nil
        }
    }
    
    /// Fetches a list of entities based on certain predicates
    ///
    /// - Parameters:
    ///   - entityName: The name of the entity
    ///   - entityType: The expected type of the fetch request
    ///   - predicates: A list of predicates to filter by, if any
    ///   - sortDescriptors: A list of sort descriptors to sort by, if any
    ///   - propertiesToGroupBy: A list of properties to group by, if any
    ///
    /// - Returns: A list of the entities fetched or nil if error
    static public func fetchEntities<T: NSFetchRequestResult>(withEntity entityName: String, expecting entityType: T.Type, predicates: [NSPredicate] = [], sortDescriptors: [NSSortDescriptor] = [], propertiesToGroupBy: [String] = []) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        // Add predicates to the fetch request, if provided
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.sortDescriptors = sortDescriptors
        
        
        if !propertiesToGroupBy.isEmpty {
            assert(entityType == NSDictionary.self, "If grouping by an attribute, an NSDictionary is expected")
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = propertiesToGroupBy
            fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        }
        
        return executeFetchRequest(expecting: entityType, with: fetchRequest)
    }
    
    static public func save() {
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    
    /// Gets the count of a particular entity
    ///
    /// - Parameters:
    ///   - entityName: The name of the entity
    ///   - entityType: The expected type of the fetch request
    ///   - predicates: A list of predicates to filter by, if any
    ///   
    /// - Returns: The count of the enitty or 0 if an error occurs
    static public func entityCount<T: NSFetchRequestResult>(withEntityName entityName: String, expecting entityType: T.Type, predicates: [NSPredicate] = []) -> Int {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        // Add predicates to the fetch request, if provided
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print("Error getting count for: \(entityName) with error \(error)")
            return 0
        }
    }
    
}
