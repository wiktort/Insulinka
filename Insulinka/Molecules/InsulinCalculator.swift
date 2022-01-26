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
    var hasPaddingBottom: Bool = false
    
    var body: some View {
        
            Section {
                Text("Podaj ilość gram makro składników na 100g dania").padding()
                GeometryReader { geometry in
                    HStack {
                        Label("Tłuszcze", systemImage: "1.circle")
                            .labelStyle(.titleOnly)
                        Spacer()
                        NumberInput(placeholder: "tłuszcze", value: $fats)
                            .frame(width: geometry.size.width * 0.6)
                    }.frame(height: geometry.size.height)
                        
                }.frame(height: 40)
                GeometryReader { geometry in
                    HStack {
                        Label("Białka", systemImage: "2.circle")
                        .labelStyle(.titleOnly)
                        Spacer()
                        NumberInput(placeholder: "białka",value: $proteins)
                            .frame(width: geometry.size.width * 0.6)
                    }.frame(height: geometry.size.height)
                }.frame(height: 40)
                GeometryReader { geometry in
                    HStack {
                        Label("Węglowodany", systemImage: "3.circle")
                            .labelStyle(.titleOnly)
                        Spacer()
                        NumberInput(placeholder: "węglowodany",value: $carbs)
                            .frame(width: geometry.size.width * 0.6)
                    }.frame(height: geometry.size.height)
                }.frame(height: 40)
                    .if(hasPaddingBottom){view in
                        view.padding(.bottom)
                    }
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
