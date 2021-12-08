//
//  TextInput.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 03/12/2021.
//

import SwiftUI

struct TextInput: View {
    var placeholder: String = "";
    @Binding var value: String;
    
    var body: some View {
        TextField(placeholder, text: $value)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct TextInput_Previews: PreviewProvider {
    @State static var value: String = "";

    static var previews: some View {
        TextInput(placeholder: "Placeholder", value: $value)
    }
}

