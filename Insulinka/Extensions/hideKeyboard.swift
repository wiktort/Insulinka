//
//  hideKeyBoard.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 11/12/2021.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
