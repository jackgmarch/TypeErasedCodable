//
//  File.swift
//  
//
//  Created by Jack March Personal on 07/09/2022.
//

import Foundation

/// Optional Bool will be converted to false
public struct NonPresentBoolToFalse: TypeErasedCodableConverter {
    public static var ifFieldIsNotPresentInJSON: HandleNonPresent<Bool?> {
        .defaultTo(false)
    }
    
    public static func convertTo(erased: Bool?) -> Bool {
        erased ?? false
    }
    
    public static func convertFrom(represented: Bool) -> Bool? {
        represented
    }
}
