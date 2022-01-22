//
//  InsulinCalculatorView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import SwiftUI

struct InsulinCalculatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var calculatorEngine = InsulinCalculatorModel()
    
    var insulinDosePerMealText: String {
        calculatorEngine.insulinDosePerMeal > 0
        ? String(calculatorEngine.insulinDosePerMeal)
        : "n/a"
    };
    var insulinDosePer100GText: String {
        String(calculatorEngine.insulinDosePer100G)
    }
    
    @State private var isPromptVisible: Bool = false
    
    private var buttonColor: Color {
            return calculatorEngine.hasAllProperties ? .accentColor : Color("DisabledColor")
    }
        
    var body: some View {
        NavigationView {
            ZStack{
                Form {
                    Section{
                        InsulinCalculator(
                        proteins: $calculatorEngine.proteins,
                        fats: $calculatorEngine.fats,
                        carbs: $calculatorEngine.carbs
                        )
                        
                        HStack{
                            Button("Wyczyść", action: {
                                calculatorEngine.fats = nil
                                calculatorEngine.proteins = nil
                                calculatorEngine.carbs = nil
                            })
                            Spacer()
                            Button("Zapisz", action: {
                                isPromptVisible = true
                            })
                                .disabled(!calculatorEngine.hasAllProperties)
                                .foregroundColor(buttonColor)
                        }.buttonStyle(BorderlessButtonStyle())
                            .padding(.top)
                            .padding(.bottom)
                    }
                    Section{
                        Text("Waga całego dania w gramach")
                        NumberInput(value: $calculatorEngine.mealWeightInGrams)
                    }
                    Section{
                        Text("Dawka insuliny na 100g daniu: " + insulinDosePer100GText)
                            .padding()
                        Text("Dawka insuliny na cały daniu: " + insulinDosePerMealText)
                            .padding()
                    }
                }
                
                TextPrompt(
                    title: "Zapisz danie",
                    message: "Podaj nazwę dania",
                    isVisible: $isPromptVisible,
                    onDone: addMeal
                )
            }.onTapGesture {
                self.hideKeyboard()
            }.navigationTitle("Kalkulator")
        }
    }
    
    private func addMeal(name: String){
        let meal = Meal(context: self.viewContext)
        meal.id = UUID()
        meal.name = name
        meal.proteins = calculatorEngine.proteins!
        meal.fats = calculatorEngine.fats!
        meal.carbs = calculatorEngine.carbs!
        meal.insulinDosePer100G = calculatorEngine.insulinDosePer100G

        try? self.viewContext.save()
    }

}

struct InsulinCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        InsulinCalculatorView()
    }
}
