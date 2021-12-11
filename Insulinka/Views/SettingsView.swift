//
//  SettingsView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings = SettingsModel.shared;
    @StateObject var errorBoundary = ErrorBoundary.shared;
    
    @State var canShowAlert: Bool = false
    var body: some View {
        NavigationView {
            Form() {
                Section(header: Text("Profil")){
                    Label("Dane użytkownika", systemImage: "person.crop.circle")
                    TextInput(placeholder: "Wprowadź swoje imię", value: $settings.userName)
                 }
                Section(header: Text("Ustawienia kalkulatora")){
                    Label("Współczynnik węglowodanowy", systemImage: "doc.text.below.ecg")
                    NumberInput(placeholder: "Wprowadź współczynnik węglowodanowy", value: $settings.carbohydrateRatio)
                        .alert(isPresented: $canShowAlert){
                            return Alert(
                                title: Text("Error"),
                                message: Text("\(errorBoundary.errorMessage)"),
                                dismissButton: .default(Text("Ok"), action: {
                                    settings.setDefaultCarbohydrateRatio()
                                })
                            )
                        }
                }
            }.navigationTitle("Ustawienia")
        }.onTapGesture {
            self.hideKeyboard()
            self.canShowAlert = errorBoundary.hasError
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

