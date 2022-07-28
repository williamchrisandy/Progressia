//
//  TaskListViewModel.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI
import Combine

class TaskListViewModel: ObservableObject
{
    private let databaseHelper: DatabaseHelperTask
    @Published var topic: Topic

    @Published var title: String
    @Published var deadline: Date
    @Published var explanation: String
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task?
    @Published var isShowingNewTask: Bool = false
    
    private var cancellable: AnyCancellable!
    
    init(topic: Topic)
    {
        self.topic = topic
        
        databaseHelper = DatabaseHelperTask(fetchRequest: Task.fetchRequest(topicId: Int(topic.id)))
        
        title = topic.title
        deadline = topic.deadline
        explanation = topic.explanation
        
        cancellable = databaseHelper.$tasks.sink
        {
            [weak self] tasks in
            self?.tasks = tasks
        }
        
        if title == "Untitled Topic"
        {
            title = ""
        }
        
        if explanation == ""
        {
            explanation = "Tap to add explanation."
        }
        
        if UserDefaults.standard.bool(forKey: DatabaseHelperTask.keyNewTask) == true
        {
            selectedTask =
            DatabaseHelperTask(
                fetchRequest:
                    Task.fetchRequest(
                        id: UserDefaults.standard.integer(forKey: Task.keyLastId)
                    )
            ).tasks[0]
            isShowingNewTask = true
            UserDefaults.standard.set(false, forKey: DatabaseHelper.keyNewTask)
        }
    }
    
    func saveData(view: TaskListView)
    {
        topic.title = title
        topic.deadline = Formatter.getStartOfDate(deadline)
        topic.explanation = explanation
        
        if title == ""
        {
            topic.title = "Untitled Topic"
        }
        
        if explanation == "Tap to add explanation."
        {
            topic.explanation = ""
        }
        databaseHelper.saveContext()
        view.presentationMode.wrappedValue.dismiss()
    }
    
    func addTask()
    {
        withAnimation
        {
            selectedTask = databaseHelper.add(title: "Untitled Task", explanation: "", deadline: topic.deadline)
            if let task = selectedTask
            {
                task.topic = topic
                databaseHelper.saveContext()
                isShowingNewTask = true
                UserDefaults.standard.set(true, forKey: DatabaseHelper.keyNewTask)
            }
        }
    }
    
    func deleteTasks(offsets: IndexSet)
    {
        withAnimation
        {
            let _ = offsets.map{ let _ = databaseHelper.delete(tasks[$0]) }
        }
    }
    
}
