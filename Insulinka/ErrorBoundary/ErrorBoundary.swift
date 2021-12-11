//
//  ErrorBoundary.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 11/12/2021.
//

import Foundation

class ErrorBoundary: ObservableObject {
    static let shared = ErrorBoundary();
    private init(){}
    
    @Published
    var error: ErrorType?
    @Published
    var hasError: Bool = false {
        didSet{
            if hasError == false {
                error = nil
            }
        }
    }
    var errorMessage: String {
        error?.localizedDescription ?? ""
    }
    
    func setError(error: ErrorType){
        self.error = error
        self.hasError = true
    }

    func clearError(){
        self.error = nil
        self.hasError = false
    }
}
