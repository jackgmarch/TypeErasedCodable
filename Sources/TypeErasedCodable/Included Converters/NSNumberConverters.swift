//
//  NSNumberConverters.swift
//  
//
//  Created by Jack March on 07/09/2022.
//

import Foundation

public struct NSNumberToIntConvertible: TypeErasedCodableConverter {
    public static var ifFieldIsNotPresentInJSON: HandleNonPresent<Int?> {
        .defaultTo(nil)
    }
    
    public static func convertTo(erased: Int?) -> NSNumber? {
        erased as NSNumber?
    }
    
    public static func convertFrom(represented: NSNumber?) -> Int? {
        represented?.intValue
    }
}

public struct NSNumberToDoubleConvertible: TypeErasedCodableConverter {
    public static var ifFieldIsNotPresentInJSON: HandleNonPresent<Double?> {
        .defaultTo(nil)
    }
    
    public static func convertTo(erased: Double?) -> NSNumber? {
        erased as NSNumber?
    }
    
    public static func convertFrom(represented: NSNumber?) -> Double? {
        represented?.doubleValue
    }
}
