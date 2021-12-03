//
//  preciseRound.swift
//  Insulinka
//
//  Created by Wiktor Tumiński on 14/11/2021.
//

import Foundation

public enum DecimalPlaces {
    case one
    case two
    case three
    case four
}


public func preciseRound(
    _ value: Double,
    decimals: DecimalPlaces = .two) -> Double
{
    switch decimals {
    
    case .one:
        return round(value * 10) / 10.0
    case .two:
        return round(value * 100) / 100.0
    case .three:
        return round(value * 1000) / 1000.0
    case .four:
        return round(value * 10000) / 10000.0
    }
}


