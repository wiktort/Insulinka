//
//  SettingsView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings = SettingsModel.shared;
    var body: some View {
        VStack(){
            Form {
                Section{
                    Label("Dane użytkownika", systemImage: "person.crop.circle")
                    TextInput(placeholder: "Wprowadź swoje imię", value: $settings.userName)
                    Label("Współczynnik węglowodanowy", systemImage: "doc.text.below.ecg")
                    NumberInput(placeholder: "Wprowadź współczynnik węglowodanowy", value: $settings.carbohydrateRatio)
                 }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

