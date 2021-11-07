//
//  InsulinkaApp.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

@main
struct InsulinkaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
