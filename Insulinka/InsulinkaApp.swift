//
//  InsulinkaApp.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

@main
struct InsulinkaApp: App {
//    let persistenceController = PersistenceController.shared
    
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .foregroundColor(Color("FontColor"))
        }
    }
}
