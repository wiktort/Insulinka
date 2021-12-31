//
//  MealView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 23/12/2021.
//

import SwiftUI

struct MealView: View {
    var meal: Meal
    @State private var isEditMealViewOpen: Bool = false
    
    var body: some View {
        NavigationView{
                List{
                    if(!isEditMealViewOpen){
                        Section {
                            SectionItem(mainText: "Nazwa dania", secondaryText: meal.name!)
                        }
                        Section {
                            SectionItem(mainText: "Tłuszcze", secondaryText: String(meal.fats))
                            SectionItem(mainText: "Białka", secondaryText: String(meal.proteins))
                            SectionItem(mainText: "Węglowodany", secondaryText: String(meal.carbs))
                            SectionItem(mainText: "Dawka insuliny na 100g dania", secondaryText: String(meal.insulinDosePer100G))
                            
                        }
                    }
                }
                .sheet(isPresented: $isEditMealViewOpen){
                    EditMealView(
                        name: Binding(get: {meal.name!}, set: {meal.name = $0}),
                        proteins: Binding(get: {meal.proteins}, set: {meal.proteins = $0}),
                        carbs: Binding(get: {meal.carbs}, set: {meal.carbs = $0 }),
                        fats: Binding(get: {meal.fats}, set: {meal.fats = $0}),
                        insulinDosePer100G: Binding(get: {meal.insulinDosePer100G}, set: {meal.insulinDosePer100G = $0}),
                        isVisible: $isEditMealViewOpen
                    )
                }
                .listStyle(.insetGrouped)
                .navigationBarHidden(true)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.isEditMealViewOpen = true
                }) {
                    Image(
                        systemName: "pencil.circle"
                    ).imageScale(.large)
                }
            }
        }
        .navigationTitle("Danie")
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
