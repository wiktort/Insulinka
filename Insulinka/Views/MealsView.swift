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
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Meal.name, ascending: true)
        ],
        animation: .default)
    private var meals: FetchedResults<Meal>

    @StateObject var errorBoundary = ErrorBoundary.shared
    @State var isAddMealViewOpen = false
    @State var addButtonDisabled = false
    @State var isEditing = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(meals, id: \.self) { meal in
                    NavigationLink(
                        destination: MealView(meal: meal)
                    ) {
                        Text(meal.name ?? "")
                    }
                }
                .onDelete(perform: deleteMeal)
            }
            .environment(
                \.editMode,
                .constant(self.isEditing ? EditMode.active : EditMode.inactive)
            )
            .navigationTitle("Lista dań")
            .sheet(isPresented: $isAddMealViewOpen){
                AddMealView(isVisible: $isAddMealViewOpen)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.isEditing.toggle()
                        self.addButtonDisabled.toggle()
                    }) {
                        if self.isEditing {
                            Text("Gotowe")
                        } else {
                            Image(
                                systemName: "pencil.circle"
                            ).imageScale(.large)
                        }
                    }
                    .alert(isPresented: $errorBoundary.hasError){
                        return Alert(
                            title: Text("Error"),
                            message: Text("\(errorBoundary.errorMessage)")
                        )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        isAddMealViewOpen = true
                    }){
                        Image(systemName: "plus.circle")
                    }.disabled(addButtonDisabled)
                }
            }
        }
    }

    func deleteMeal(at offsets: IndexSet){
        for index in offsets {
            let meal = meals[index]
            self.viewContext.delete(meal)
            do {
                try self.viewContext.save()
                if ErrorBoundary.shared.error == ErrorType.saveViewContextError {
                    ErrorBoundary.shared.clearError()
                }
            } catch ErrorType.saveViewContextError {
                ErrorBoundary.shared.setError(error: ErrorType.saveViewContextError)
            } catch {
                ErrorBoundary.shared.setError(error: ErrorType.unkownError)
            }
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
