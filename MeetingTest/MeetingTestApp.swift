//
//  MeetingTestApp.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

@main
struct MeetingTestApp: App {
    
    let persistencecontroller = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            let context = persistencecontroller.container.viewContext
            let dateHolder = DateHolder(context)
            MeetingListView()
                .environment(\.managedObjectContext, persistencecontroller.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
