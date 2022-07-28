//
//  Activity+CoreDataProperties.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//
//

import Foundation
import CoreData


extension Activity
{
    static let sortDescriptors = [NSSortDescriptor(keyPath: \Activity.date, ascending: false)]
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.sortDescriptors = Activity.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = Activity.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(topicId: Int) -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "topic.id == %i or task.topic.id == %i", topicId, topicId)
        fetchRequest.sortDescriptors = Activity.sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(taskId: Int) -> NSFetchRequest<Activity>
    {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "task.id == %i", taskId)
        fetchRequest.sortDescriptors = Activity.sortDescriptors
        return fetchRequest
    }

    @NSManaged public var date: Date
    @NSManaged public var point: Int16
    @NSManaged public var mood: Double
    @NSManaged public var id: Int64
    @NSManaged public var task: Task?
    @NSManaged public var topic: Topic?

}

extension Activity: Identifiable
{

}

extension Activity: HasKeyLastId
{
    static var keyLastId: String = "activityLastId"
}

extension Activity: HasId
{
    
}
