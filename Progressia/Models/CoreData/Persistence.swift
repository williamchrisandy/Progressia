//
//  Persistence.swift
//  Progressia
//
//  Created by William Chrisandy on 22/07/22.
//

import CoreData

struct PersistenceController
{
    static let shared = PersistenceController()

    static var preview: PersistenceController =
    {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do
        {
            try viewContext.save()
        }
        catch
        {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false)
    {
        container = NSPersistentContainer(name: "Progressia")
        if inMemory
        {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(
            completionHandler:
                {
                    (storeDescription, error) in
                    if let error = error as NSError?
                    {
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        print("Unresolved error \(error), \(error.userInfo), \(error.localizedDescription)")
                    }
                }
        )
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
