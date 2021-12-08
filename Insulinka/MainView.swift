//
//  MainView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI
import Foundation
import CoreData

struct MainView: View {
    var body: some View {
        TabView {
            StartView()
                .tabItem({
                    Image(systemName: "house").resizable()
                    Text("Start")
                })
            InsulinCalculatorView()
                .tabItem({
                    Image(systemName: "brain.head.profile").resizable()
                    Text("Kalkulator")
                })
            MealsView()
                .tabItem({
                    Image(systemName: "fork.knife").resizable()
                    Text("Posiłki")
                })
            SettingsView()
                .tabItem({
                    Image(systemName: "gearshape").resizable()
                    Text("Ustawienia")
                })
                
        }.accentColor(Color("CtaFontColor"))
        }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
