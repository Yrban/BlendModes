//
//  BlendingModesApp.swift
//  BlendingModes
//
//  Created by Developer on 10/1/21.
//

import SwiftUI

@main
struct BlendingModesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
