//
//  SettingsModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import Foundation

// The SettingsModel is a Singleton
class SettingsModel: ObservableObject {
    static let Singleton = SettingsModel();
    @Published var userName: String = "userName";
    @Published var carbohydrateRatio: Float32 = 12.00;
    
}
