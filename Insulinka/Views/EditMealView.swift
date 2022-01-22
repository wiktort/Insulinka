//
//  EditMealView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 31/12/2021.
//

import SwiftUI

struct EditMealView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var calculatorEngine = InsulinCalculatorModel()
    @StateObject private var mealModel = MealModel()
    
    @Binding var name: String
    @Binding var proteins: Float32
    @Binding var carbs: Float32
    @Binding var fats: Float32
    @Binding var insulinDosePer100G: Float32
    @Binding var isVisible: Bool
   
    var insulinDosePer100GText: String {
        String(preciseRound(
            Double(calculatorEngine.insulinDosePer100G)
        ))
    }
    
    private var buttonColor: Color {
        return calculatorEngine.hasAllProperties ? Color("FontColor") : Color("DisabledColor")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Nazwa")
                    TextInput(
                        placeholder: "Podaj nazwę dania",
                        value: $mealModel.mealName
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
                    Spacer()
                    Button("Zapisz", action: {
                        updateMeal()
                        isVisible = false
                    })
                        .disabled(!calculatorEngine.hasAllProperties || name.count < 1)
                        .foregroundColor(buttonColor)
                }
                
                
            }.onTapGesture {
                self.hideKeyboard()
            }
            .onAppear(perform: {
                self.mealModel.mealName = self.name
                self.calculatorEngine.proteins = self.proteins
                self.calculatorEngine.carbs = self.carbs
                self.calculatorEngine.fats = self.fats
            })
            .navigationTitle("Edytuj danie")
            .navigationBarTitleDisplayMode(.inline)
            .buttonStyle(BorderlessButtonStyle())
        }      
    }
    func updateMeal(){
        viewContext.performAndWait {
            self.name = mealModel.mealName
            self.proteins = calculatorEngine.proteins!
            self.fats = calculatorEngine.fats!
            self.carbs = calculatorEngine.carbs!
            self.insulinDosePer100G = calculatorEngine.insulinDosePer100G

            try? viewContext.save()
        }
    }
}

struct EditMealView_Previews: PreviewProvider {
    static var previews: some View {
        EditMealView(
            name: .constant("name"),
            proteins: .constant(0.00),
            carbs: .constant(0.00),
            fats: .constant(0.00),
            insulinDosePer100G: .constant(0.00),
            isVisible: .constant(true)
        )
    }
}
