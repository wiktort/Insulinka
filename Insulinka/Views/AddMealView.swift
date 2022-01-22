//
//  AddMealView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 30/12/2021.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var calculatorEngine = InsulinCalculatorModel()
    @State private var mealName: String = ""
    
    @Binding var isVisible: Bool
   
    var insulinDosePer100GText: String {
        String(preciseRound(
            Double(calculatorEngine.insulinDosePer100G)
        ))
    }
    
    private var buttonColor: Color {
            return calculatorEngine.hasAllProperties ? .accentColor : Color("DisabledColor")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Nazwa")
                    TextInput(
                        placeholder: "Podaj nazwę dania",
                        value: $mealName
                    )
                }
                
                Section{
                    InsulinCalculator(
                        proteins: $calculatorEngine.proteins,
                        fats: $calculatorEngine.fats,
                        carbs: $calculatorEngine.carbs,
                        hasPaddingBottom: true
                    )
                    
                }
                
                Section{
                    Text("Dawka insuliny na 100g dania: " + insulinDosePer100GText)
                        .padding()
                }
                
                HStack{
                    Button("Wyczyść", action: {
                        calculatorEngine.fats = nil
                        calculatorEngine.proteins = nil
                        calculatorEngine.carbs = nil
                    })
                    Spacer()
                    Button("Zapisz", action: {
                        addMeal(name: mealName)
                        isVisible = false
                    })
                        .disabled(!calculatorEngine.hasAllProperties || mealName.count < 1)
                        .foregroundColor(buttonColor)
                }
                
                
            }.onTapGesture {
                self.hideKeyboard()
            }
            .buttonStyle(BorderlessButtonStyle())
            .navigationTitle("Dodaj danie")
        }
    }
    func addMeal(name: String){
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

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(isVisible: .constant(true))
    }
}
