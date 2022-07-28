//
//  ChangeCompletionViewModel.swift
//  Progressia
//
//  Created by William Chrisandy on 29/07/22.
//

import SwiftUI

class ChangeCompletionViewModel: ObservableObject
{
    private let databaseHelper = DatabaseHelper()
    
    let basePoint: Int
    let mood: Double
    var points: [Int: Int] = [2 : 0]
    @Published var task: Task
    @Published var completion: Int
    
    init(task: Task, basePoint: Int, mood: Double)
    {
        self.task = task
        self.basePoint = basePoint
        self.mood = mood
        completion = Int(task.completion)
        
        points[1] = Int(Double(basePoint + 1000) * mood)
        points[3] = Int(Double(basePoint + 3000) * mood)
    }
    
    func saveData(view: ChangeCompletionView)
    {
        task.completion = Int16(completion)
        
        let databaseHelperActivity = DatabaseHelperActivity(fetchRequest: Activity.fetchRequest(taskId: Int(task.id)))
        
        if completion != 2
        {
            let activity = databaseHelperActivity.add(
                date: Date(),
                point: points[completion]!,
                mood: mood
            )
            activity.task = task
            
            if task.topic?.getCompletionStatus() == "Completed" && task.topic!.deadline >= Formatter.getStartOfDate(Date())
            {
                let activity = databaseHelperActivity.add(
                    date: Date(),
                    point: 100 * Formatter.dateDifferences(Date(), task.topic!.deadline),
                    mood: mood
                )
                activity.topic = task.topic
            }
        }
        databaseHelper.saveContext()
        cancel(view: view)
    }
    
    func cancel(view: ChangeCompletionView)
    {
        view.presentationMode.wrappedValue.dismiss()
    }
}
