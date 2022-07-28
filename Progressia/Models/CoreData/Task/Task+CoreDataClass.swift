//
//  Task+CoreDataClass.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject
{
    static let difficultyDictionary =
    [
        1: "Easy",
        2: "Medium",
        3: "Hard"
    ]
    
    static let completionDictionary =
    [
        1: "In Progress",
        2: "Not Started",
        3: "Completed"
    ]
}
