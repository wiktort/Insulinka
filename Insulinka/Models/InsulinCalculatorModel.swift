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

    @Published var proteins: Float32? = nil;
    @Published var fats: Float32? = nil;
    @Published var carbs: Float32? = nil;
    @Published var mealWeightInGrams: Float32? = nil;
    
    var insulinDosePer100G: Float32 {
        let proteinDose = (proteins ?? 0.00) * 4 / 100;
        let fatDose = (fats ?? 0.00) * 9 / 100;
        let carbohydrateDose = (carbs ?? 0.00) / settings.carbohydrateRatio!;

        return proteinDose + fatDose + carbohydrateDose;
    }
    
    var insulinDosePerMeal: Float32 {
        return insulinDosePer100G * (mealWeightInGrams ?? 0.00) / 100;
    }
    
}
