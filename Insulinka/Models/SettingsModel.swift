//
//  SettingsModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import Foundation
import UIKit
import SwiftUI

let DEFAULT_CARBOHYDRATE_RATIO: Float32 = 12.00

func checkRatio(ratio: Float32?) throws -> Float32 {
    guard ratio != nil else {
        throw ErrorType.invalidCarbohydrateRatio
    }
    return ratio!
}

// The SettingsModel is a Singleton
class SettingsModel: ObservableObject {
    static let shared = SettingsModel();
    @Published var userName: String {
        didSet{
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    @Published var carbohydrateRatio: Float32? {
        didSet {
            do {
                try UserDefaults.standard.set(checkRatio(ratio: carbohydrateRatio), forKey: "carbohydrateRatio")
                if ErrorBoundary.shared.error == ErrorType.invalidCarbohydrateRatio {
                    ErrorBoundary.shared.clearError()
                }
            } catch ErrorType.invalidCarbohydrateRatio {
                ErrorBoundary.shared.setError(error: ErrorType.invalidCarbohydrateRatio)
            } catch {
                ErrorBoundary.shared.setError(error: ErrorType.unkownError)
            }

        }
    }
    
    func setDefaultCarbohydrateRatio(){
        carbohydrateRatio = DEFAULT_CARBOHYDRATE_RATIO
    }
    
    private init(){
        UserDefaults.standard.register(
            defaults: [
                "userName": UIDevice.current.name,
                "carbohydrateRatio": DEFAULT_CARBOHYDRATE_RATIO
            ]
        )
        self.userName = UserDefaults.standard.string(forKey: "userName")!
        self.carbohydrateRatio = UserDefaults.standard.float(forKey: "carbohydrateRatio")
    }
}
