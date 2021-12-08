//
//  SettingsModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import Foundation

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
        self.userName = UserDefaults.standard.string(forKey: "userName")!
        self.carbohydrateRatio = UserDefaults.standard.float(forKey: "carbohydrateRatio")
    }
}
