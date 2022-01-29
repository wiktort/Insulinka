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
  // it is unsued but defining it assures that the view reacts to changes in SettingsModel
  @StateObject var settings = SettingsModel.shared
  
  var insulinDosePerMealText: String {
    calculatorEngine.insulinDosePerMeal > 0.00
    ? String(calculatorEngine.insulinDosePerMeal)
    : "n/a"
  };
  var insulinDosePer100GText: String {
    calculatorEngine.insulinDosePer100G > 0.00
    ? String(calculatorEngine.insulinDosePer100G)
    : "n/a"
  }
  
  @State private var isPromptVisible: Bool = false
  
  private var buttonColor: Color {
    return calculatorEngine.hasAllProperties ? .accentColor : Color("DisabledColor")
  }
  
  var body: some View {
    NavigationView {
      ZStack{
        Form {
          
          InsulinCalculator(
            proteins: $calculatorEngine.proteins,
            fats: $calculatorEngine.fats,
            carbs: $calculatorEngine.carbs,
            hasPaddingBottom: true
          )
          
          Section{
            HStack{
              Label("Waga dania (gram)", systemImage: "none")
                .labelStyle(.titleOnly)
              NumberInput(placeholder: "Podaj wagę posiłku", value: $calculatorEngine.mealWeightInGrams)
            }
            
            HStack{
              Button("Wyczyść", action: calculatorEngine.clearProperties)
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
            Text("Dawka insuliny na 100g dania: " + insulinDosePer100GText)
              .padding()
            Text("Dawka insuliny na całe danie: " + insulinDosePerMealText)
              .padding()
          }
        }
        
        TextPrompt(
          title: "Zapisz danie",
          placeholder: "nazwa",
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
