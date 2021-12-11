//
//  ErrorTypes.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 11/12/2021.
//

import Foundation

public enum ErrorType: Error {
    case invalidCarbohydrateRatio
    case unkownError
}

extension ErrorType: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidCarbohydrateRatio:
            return NSLocalizedString("Współczynnik węglowodanowy musi być liczbą dodatnią", comment: "ErrorType")
        case .unkownError:
            return NSLocalizedString("Nieznany błąd", comment: "ErrorType" )
        }
    }
}
