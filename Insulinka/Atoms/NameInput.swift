//
//  NameInput.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 03/12/2021.
//

import SwiftUI

struct NameInput: View {
    var placeholder: String = "";
    @Binding var value: PersonNameComponents;
    
    var body: some View {
        TextField(placeholder, value: $value, format: .name(style: .short))
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct NameInput_Previews: PreviewProvider {
    @State static var value = PersonNameComponents();
    
    static var previews: some View {
        NameInput(placeholder: "Placeholder", value: $value)
    }
}

