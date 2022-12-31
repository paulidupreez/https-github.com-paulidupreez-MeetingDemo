//
//  Persistence.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext


        let meeting     = Meeting(context: viewContext)
        meeting.name    = "City Serenity"
        meeting.type    = "Open"
        meeting.meetingDate     = Date()
        meeting.detail  = "All is welcome to attend"
        meeting.address = "St Mary’s Church (Garden Room) N1 2TX"
        meeting.isFavourite = false
        meeting.isWeekly    = false


        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    static var testData: [Meeting]? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meeting")
        return try? PersistenceController.preview.container.viewContext.fetch(fetchRequest) as? [Meeting]
    }()
    
   
    
    
    
    

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MeetingModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

