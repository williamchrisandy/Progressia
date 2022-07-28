//
//  Topic+CoreDataProperties.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//
//

import Foundation
import CoreData


extension Topic
{
    static let sortDescriptors = [NSSortDescriptor(keyPath: \Topic.deadline, ascending: false)]
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic>
    {
        let fetchRequest = NSFetchRequest<Topic>(entityName: "Topic")
        fetchRequest.sortDescriptors = Topic.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Topic>
    {
        let fetchRequest = NSFetchRequest<Topic>(entityName: "Topic")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = Topic.sortDescriptors
        return fetchRequest
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var explanation: String
    @NSManaged public var deadline: Date
    @NSManaged public var tasks: NSSet?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for tasks
extension Topic
{

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

// MARK: Generated accessors for activities
extension Topic
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

extension Topic: Identifiable
{

}

extension Topic: HasKeyLastId
{
    static var keyLastId: String = "topicLastId"
}

extension Topic: HasId
{
    
}
