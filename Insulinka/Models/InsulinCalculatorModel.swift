//
//  InsulinCalculatorModel.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import Foundation
import SwiftUI

class InsulinCalculatorModel: ObservableObject {
    @ObservedObject private var settings = SettingsModel.shared

    @Published var proteins: Float32? = nil
    @Published var fats: Float32? = nil
    @Published var carbs: Float32? = nil
    @Published var mealWeightInGrams: Float32? = nil
    @Published var mealName: String = ""
    
    var hasAllProperties: Bool {
        proteins != nil && fats != nil && carbs != nil
    }
    
    private var insulinDosePer100GUnrounded: Float32 {
        let proteinDose = (proteins ?? 0.00) * 4 / 100
        let fatDose = (fats ?? 0.00) * 9 / 100
        let carbohydrateDose = (carbs ?? 0.00) / (settings.carbohydrateRatio ?? 0.00)

        return Float32(preciseRound(Double(proteinDose + fatDose + carbohydrateDose), decimals: DecimalPlaces.two))
    }
    
    var insulinDosePer100G: Float32 {
        return Float32(preciseRound(Double(self.insulinDosePer100GUnrounded), decimals: DecimalPlaces.two))
    }
    
    var insulinDosePerMeal: Float32 {
        return Float32(preciseRound(Double(insulinDosePer100GUnrounded * (mealWeightInGrams ?? 0.00)) / 100, decimals: DecimalPlaces.two))
    }
  
  func clearProperties(){
    self.fats = nil
    self.proteins = nil
    self.carbs = nil
    self.mealWeightInGrams = nil
  }
    
}
