//
//  SectionItem.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 29/12/2021.
//

import SwiftUI

struct SectionItem: View {
    let mainText: String
    let secondaryText: String
    var body: some View {
        HStack {
            Text(mainText)
            Spacer()
            Text(secondaryText)
                .foregroundColor(Color("GreyFontColor"))
        }
    }
}

struct SectionItem_Previews: PreviewProvider {
    static var previews: some View {
        SectionItem(mainText: "Name", secondaryText: "test name")
    }
}
