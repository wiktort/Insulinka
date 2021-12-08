//
//  StartView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

struct StartView: View {
    @StateObject private var settings = SettingsModel.shared

    var body: some View {
        VStack(){
            Image("candy")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .accessibilityLabel("logo")
            Text("Cześć, " + settings.userName + "!")
                .font(.title)
                .foregroundColor(Color("CtaFontColor"))
                .fontWeight(Font.Weight.bold)
                .padding(.top, 50)
                .padding(.bottom,20)
                .padding(.horizontal, 10)
        }
    }}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
