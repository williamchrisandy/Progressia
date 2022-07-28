//
//  DatabaseHelperTask.swift
//  Progressia
//
//  Created by William Chrisandy on 25/07/22.
//

import CoreData

class DatabaseHelperTask: DatabaseHelper
{
    @Published var tasks: [Task] = []
    private var controller: NSFetchedResultsController<Task>!
    
    init(fetchRequest: NSFetchRequest<Task>)
    {
        super.init()
        
        controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        
        performFetch()
        refreshData()
    }
    
    func performFetch()
    {
        do
        {
            try controller.performFetch()
        }
        catch
        {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
        }
    }
    
    func refreshData()
    {
        guard let tasks = controller.fetchedObjects
        else { return }
        
        self.tasks = tasks
    }
    
    func add(title: String, explanation: String, deadline: Date) -> Task
    {
        let newObject = Task(context: context)
        newObject.title = title
        newObject.explanation = explanation
        newObject.deadline = deadline
        newObject.difficulty = Int16(2)
        newObject.completion = Int16(2)
        return insert(newObject)
    }
}

extension DatabaseHelperTask: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        refreshData()
    }
}
