//
//  InsulinCalculator.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 30/12/2021.
//

import SwiftUI

struct InsulinCalculator: View {
    
    @Binding  var proteins: Float32?
    @Binding  var fats: Float32?
    @Binding  var carbs: Float32?

    var body: some View {
        Section {
            Text("Podaj ilość gram makro składników na 100g dania").padding()
            Label("Tłuszcze", systemImage: "1.circle")
            NumberInput(value: $fats)
            Label("Białka", systemImage: "2.circle")
            NumberInput(value: $proteins)
            Label("Węglowodany", systemImage: "3.circle")
            NumberInput(value: $carbs)
        }
    }
}

struct InsulinCalculator_Previews: PreviewProvider {
    @StateObject var calculatorEngine = InsulinCalculatorModel()
    static var previews: some View {
        InsulinCalculator(
            proteins: .constant(0.00),
            fats: .constant(0.00),
            carbs: .constant(0.00)
        )
    }
}
