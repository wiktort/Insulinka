//
//  InsulinCalculatorView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import SwiftUI

struct InsulinCalculatorView: View {
    @StateObject var calculatorEngine = InsulinCalculatorModel();
    
    var insulinDosePerMealText: String {
        calculatorEngine.insulinDosePerMeal > 0
        ? String(preciseRound(
            Double( calculatorEngine.insulinDosePerMeal)
            ))
        : "n/a"
    };
    var insulinDosePer100GText: String {
        String(preciseRound(
            Double(calculatorEngine.insulinDosePer100G)
        ))
    }
    var body: some View {
        VStack(){
            Form {
                Section{
                    Text("Podaj ilość gram makro składników na 100g posiłku").padding()
                    Label("Tłuszcze", systemImage: "1.circle")
                    NumberInput(value: $calculatorEngine.fats)
                    Label("Białka", systemImage: "2.circle")
                    NumberInput(value: $calculatorEngine.proteins)
                    Label("Węglowodany", systemImage: "3.circle")
                    NumberInput(value: $calculatorEngine.carbs)
                }
                Section{
                    Text("Waga całego posiłku w gramach")
                    NumberInput(value: $calculatorEngine.mealWeightInGrams)
                }
                Section{
                    Text("Dawka insuliny na 100g posiłku: " + insulinDosePer100GText)
                        .padding()
                    Text("Dawka insuliny na cały posiłek: " + insulinDosePerMealText)
                        .padding()
                }
            }
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct InsulinCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        InsulinCalculatorView()
    }
}
