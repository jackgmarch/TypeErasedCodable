//
//  TypeErasedCodableConverter.swift
//  
//
//  Created by Jack March on 07/09/2022.
//

import Foundation

public enum HandleNonPresent<T> {
    case throwError
    case defaultTo(T)
}

public protocol TypeErasedCodableConverter {
    associatedtype ErasedCodable: Codable
    associatedtype Represented
    static func convertTo(erased: ErasedCodable) -> Represented
    static func convertFrom(represented: Represented) -> ErasedCodable
    static var ifFieldIsNotPresentInJSON: HandleNonPresent<ErasedCodable> { get }
}
