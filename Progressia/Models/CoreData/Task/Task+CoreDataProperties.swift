//
//  Task+CoreDataProperties.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//
//

import Foundation
import CoreData


extension Task
{
    static let sortDescriptors =
    [
        NSSortDescriptor(keyPath: \Task.completion, ascending: true),
        NSSortDescriptor(keyPath: \Task.deadline, ascending: false),
        NSSortDescriptor(keyPath: \Task.difficulty, ascending: true)
    ]
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task>
    {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.sortDescriptors = Task.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Task>
    {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = Task.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(topicId: Int) -> NSFetchRequest<Task>
    {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "topic.id == %i", Int64(topicId))
        fetchRequest.sortDescriptors = Task.sortDescriptors
        return fetchRequest
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var explanation: String
    @NSManaged public var deadline: Date
    @NSManaged public var difficulty: Int16
    @NSManaged public var completion: Int16
    @NSManaged public var topic: Topic?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for activities
extension Task
{

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension Task: Identifiable
{

}

extension Task: HasKeyLastId
{
    static var keyLastId: String = "taskLastId"
}

extension Task: HasId
{
    
}
