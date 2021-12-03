//
//  NumberInput.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import SwiftUI

struct NumberInput: View {
    var placeholder: String = "Wprowadź wartość";
    @Binding var value: Float32;
    
    var body: some View {
        TextField(placeholder, value: $value, format: .number)
                       .textFieldStyle(.roundedBorder)
                       .keyboardType(.decimalPad)
                       .padding()
    }
}

struct NumberInput_Previews: PreviewProvider {
    @State static var value: Float32 = 12.00;
    static var previews: some View {
        NumberInput(placeholder: "Placeholder", value: $value)
    }
}

