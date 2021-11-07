//
//  StartView.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

struct StartView: View {
    @StateObject var viewRouter: ViewRouter


    var body: some View {
        VStack(){
            Image("candy")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .accessibilityLabel("logo")
            Text("Cześć, " + "userName" + "!")
                .font(.title)
                .foregroundColor(Color("CtaFontColor"))
                .fontWeight(Font.Weight.bold)
                .padding(.top, 50)
                .padding(.bottom,20)
                .padding(.horizontal, 10)

            Button("Naciśnij, aby zacząć", action: {
            })
  
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .overlay(RoundedRectangle(cornerRadius: 30.0).strokeBorder(Color("CtaFontColor"), lineWidth: 3.0))
                .hoverEffect(.highlight)
        }
    }}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewRouter: ViewRouter())
            
    }
}
