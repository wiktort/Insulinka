//
//  MealsView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 03/12/2021.
//

import SwiftUI

struct MealsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var meals: FetchedResults<Meal>
    var body: some View {
        VStack{
            List(meals) {meal in
                Text(meal.name ?? "Inne")
            }
            Button("add"){
                addMeal()
            }
    }
        
    }
    
    func addMeal(){
        let meal = Meal(context: viewContext)
        meal.id = UUID()
        meal.name = "testMeal"
        meal.insulinDosePer100G = 10.0
        
        try? viewContext.save()
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
