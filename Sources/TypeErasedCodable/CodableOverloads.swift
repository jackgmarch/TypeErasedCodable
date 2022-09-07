//
//  CodableOverloads.swift
//  
//
//  Created by Jack March on 07/09/2022.
//

import Foundation

// These overloads are called internally by Codable

extension KeyedDecodingContainer {
    /// This overload is called internally by Codable
    func decode<T>(_ type: TypeErasedCodable<T>.Type, forKey key: Key) throws -> TypeErasedCodable<T> {
        guard let present = try decodeIfPresent(type, forKey: key) else {
            switch T.ifFieldIsNotPresentInJSON {
            case .throwError:
                throw FieldMissingError(key: key.stringValue, type: type)
            case .defaultTo(let value):
                return .init(customValue: value)
            }
        }
        
        return present
    }
}

extension KeyedEncodingContainer {
    /// Used to make make sure wrappers don't encode "null" when it's wrappedValue is nil.
    /// https://github.com/GottaGetSwifty/CodableWrappers/blob/master/Sources/CodableWrappers/Core/OptionalWrappers.swift#L38
    ///
    /// This overload is called internally by Codable
    public mutating func encode<T>(_ value: TypeErasedCodable<T>, forKey key: Key) throws {

        if case Optional<Any>.none = value.wrappedValue as Any {
            return
        }

        try encodeIfPresent(value, forKey: key)
    }
}
