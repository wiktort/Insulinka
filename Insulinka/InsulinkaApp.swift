//
//  InsulinkaApp.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

@main
struct InsulinkaApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.persistentContainer.viewContext)
                .foregroundColor(Color("FontColor"))
        }
    }
}
