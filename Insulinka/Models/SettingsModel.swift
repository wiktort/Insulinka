//
//  SettingsModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import Foundation
import UIKit

// The SettingsModel is a Singleton
class SettingsModel: ObservableObject {
    static let shared = SettingsModel();
    @Published var userName: String {
        didSet{
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    @Published var carbohydrateRatio: Float32 {
        didSet{
            UserDefaults.standard.set(carbohydrateRatio, forKey: "carbohydrateRatio")
        }
    }
    
    
    private init(){
        UserDefaults.standard.register(
            defaults: [
                "userName": UIDevice.current.name,
                "carbohydrateRatio": 12.00
            ]
        )
        self.userName = UserDefaults.standard.string(forKey: "userName")!
        self.carbohydrateRatio = UserDefaults.standard.float(forKey: "carbohydrateRatio")
    }
}
