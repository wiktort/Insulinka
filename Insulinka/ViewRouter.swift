//
//  ViewRouter.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 07/11/2021.
//

import SwiftUI

enum Page {
    case StartView
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .StartView
}
