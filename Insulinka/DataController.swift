//
//  DataController.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 08/12/2021.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let persistentContainer = NSPersistentContainer(name: "Insulinka")
    
    init(){
        persistentContainer.loadPersistentStores {description , error in
            if let error = error {
                print("Core Data failed to \(error.localizedDescription)")
            }
        }
    }
}
