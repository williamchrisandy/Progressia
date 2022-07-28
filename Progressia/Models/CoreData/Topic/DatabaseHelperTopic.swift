//
//  DatabaseHelperTopic.swift
//  Progressia
//
//  Created by William Chrisandy on 25/07/22.
//

import CoreData

class DatabaseHelperTopic: DatabaseHelper
{
    @Published var topics: [Topic] = []
    private var controller: NSFetchedResultsController<Topic>!
    
    init(fetchRequest: NSFetchRequest<Topic>)
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
        guard let topics = controller.fetchedObjects
        else { return }
        
        self.topics = topics
    }
    
    func add(title: String, explanation: String, deadline: Date) -> Topic
    {
        let newObject = Topic(context: context)
        newObject.title = title
        newObject.explanation = explanation
        newObject.deadline = deadline
        return insert(newObject)
    }
}

extension DatabaseHelperTopic: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        refreshData()
    }
}
