//
//  StartView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

struct StartView: View {
    private let userName: String = SettingsModel.Singleton.userName;


    var body: some View {
        VStack(){
            Image("candy")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .accessibilityLabel("logo")
            Text("Cześć, " + userName + "!")
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
