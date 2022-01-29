//
//  TextPrompt.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 30/12/2021.
//

import SwiftUI

struct TextPrompt: View {
      let screenSize = UIScreen.main.bounds
      var title: String
      var placeholder: String = ""
      var message: String?
      
      @Binding var isVisible: Bool
      @State private var value: String = ""
      
      var onDone: (String) -> Void = { _ in }
      var onCancel: () -> Void = { }
      
      var body: some View {
            if isVisible {
                  VStack(spacing: 20) {
                        Text(title).font(.headline)
                        if(message != nil){
                              Text(message!)
                        }
                        TextField(placeholder, text: $value)
                              .textFieldStyle(RoundedBorderTextFieldStyle())
                        HStack(spacing: 20) {
                              Button("Anuluj", action: {
                                    self.isVisible = false
                                    self.hideKeyboard()
                                    self.value = ""
                                    self.onCancel()
                              })
                              Button("Potwierdź", action: {
                                    self.isVisible = false
                                    self.hideKeyboard()
                                    self.onDone(self.value)
                                    self.value = ""
                              })
                        }
                  }
                  .padding()
                  .frame(width: screenSize.width * 0.7)
                  .background(Color("BackgroundColor"))
                  .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                  .offset(y: isVisible ? 0 : screenSize.height)
            }
      }
}

struct TextPrompt_Previews: PreviewProvider {
      static var previews: some View {
            TextPrompt(title: "Add Item", message: "Message", isVisible: .constant(true))
      }
}
