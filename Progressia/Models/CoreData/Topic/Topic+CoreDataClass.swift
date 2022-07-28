//
//  Topic+CoreDataClass.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//
//

import Foundation
import CoreData

@objc(Topic)
public class Topic: NSManagedObject
{
    func getCompletionStatus() -> String
    {
        var notStarted = false
        let tasks = tasks?.allObjects as! [Task]
        
        for task in tasks
        {
            if task.completion == 1
            {
                return Task.completionDictionary[Int(task.completion)]!
            }
            else if task.completion == 2
            {
                notStarted = true
            }
        }
        return notStarted == true ? Task.completionDictionary[2]! : Task.completionDictionary[3]!
    }
}
