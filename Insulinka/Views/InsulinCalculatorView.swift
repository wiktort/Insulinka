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
    
    @State private var isPromptVisible: Bool = false
    
    private var buttonColor: Color {
            return calculatorEngine.hasAllProperties ? .accentColor : Color("DisabledColor")
    }
        
    var body: some View {
        ZStack{
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
            
            TextPrompt(
                title: "Zapisz posiłek",
                message: "String",
                isVisible: $isPromptVisible,
                onDone: addMeal
            )
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
