//
//  SettingsView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 28/11/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(){
            TextField("Wprowadź swoje imię", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            TextField("Wprowadź współczynnik węglowodanowy", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

