//
//  InsulinCalculatorModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import Foundation
import SwiftUI

class InsulinCalculatorModel: ObservableObject {
    @ObservedObject private var settings = SettingsModel.shared;
    var carbohydrateRatio: Float32 {
        settings.carbohydrateRatio
    }
    @Published var proteins: Float32 = 0.00;
    @Published var fats: Float32 = 0.00;
    @Published var carbs: Float32 = 0.00;
    @Published var mealWeightInGrams: Float32 = 0.00;
    
    var insulinDosePer100G: Float32 {
        let proteinDose = proteins * 4 / 100;
        let fatDose = fats * 9 / 100;
        let carbohydrateDose = carbs / carbohydrateRatio;

        return proteinDose + fatDose + carbohydrateDose;
    }
    
    var insulinDosePerMeal: Float32 {
        return insulinDosePer100G * mealWeightInGrams / 100;
    }
    
}
