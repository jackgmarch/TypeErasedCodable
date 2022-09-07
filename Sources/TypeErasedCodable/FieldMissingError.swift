//
//  FieldMissingError.swift
//  
//
//  Created by Jack March on 07/09/2022.
//

import Foundation

struct FieldMissingError: Error {
    let key: String
    let type: Any.Type
    
    var localizedDescription: String {
        "Key '\(key)' missing for type \(type)"
    }
}
