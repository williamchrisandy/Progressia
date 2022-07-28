//
//  DatabaseHelperActivity.swift
//  Progressia
//
//  Created by William Chrisandy on 25/07/22.
//

import CoreData

class DatabaseHelperActivity: DatabaseHelper
{
    @Published var activities: [Activity] = []
    private var controller: NSFetchedResultsController<Activity>!
    
    init(fetchRequest: NSFetchRequest<Activity>)
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
        guard let activities = controller.fetchedObjects
        else { return }
        
        self.activities = activities
    }
    
    func add(date: Date, point: Int, mood: Double) -> Activity
    {
        let newObject = Activity(context: context)
        newObject.date = date
        newObject.point = Int16(point)
        newObject.mood = mood
        return insert(newObject)
    }
}

extension DatabaseHelperActivity: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        refreshData()
    }
}
