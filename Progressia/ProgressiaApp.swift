//
//  ProgressiaApp.swift
//  Progressia
//
//  Created by William Chrisandy on 22/07/22.
//

import SwiftUI

@main
struct ProgressiaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
