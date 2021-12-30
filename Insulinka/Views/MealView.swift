//
//  MealView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 23/12/2021.
//

import SwiftUI

struct MealView: View {
    let meal: Meal
    @State static var isEditing: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                Section {
                    SectionItem(mainText: "Nazwa posiłku", secondaryText: meal.name!)
                }
                Section {
                    SectionItem(mainText: "Tłuszcze", secondaryText: String(meal.fats))
                    SectionItem(mainText: "Węglowodany", secondaryText: String(meal.carbs))
                    SectionItem(mainText: "Białka", secondaryText: String(meal.proteins))
                    SectionItem(mainText: "Dawka insuliny na 100g posiłku", secondaryText: String(meal.insulinDosePer100G))
                    
                }
//                InsulinCalculatorView()
            }
            .listStyle(.insetGrouped)
            .navigationBarHidden(true)
            .toolbar {
                
            }
        }.navigationTitle(Text("Posiłek"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController().persistentContainer.viewContext
        let meal = Meal.init(context: viewContext)
        meal.id = UUID()
        meal.name = "test meal"
        meal.insulinDosePer100G = 0.00
        return MealView(meal: meal)
            .environment(\.managedObjectContext, viewContext)
    }
}
