import Foundation

@propertyWrapper
public struct TypeErasedCodable<Converter: TypeErasedCodableConverter> {
    public var wrappedValue: Converter.Represented {
        get {
            Converter.convertTo(erased: state.value)
        } set {
            // If we set a custom value, we don't re encode the originally coded value
            state = .customValue(Converter.convertFrom(represented: newValue))
        }
    }
    
    /// If we set customValue, ignore
    private enum State {
        case customValue(Converter.ErasedCodable)
        case decoded(Converter.ErasedCodable)
        
        var value: Converter.ErasedCodable {
            switch self {
            case .customValue(let value):
                return value
            case .decoded(let value):
                return value
            }
        }
    }
    
    private var state: State
    
    init(customValue: Converter.ErasedCodable) {
        state = .customValue(customValue)
    }
}

extension TypeErasedCodable: Codable {
    
    public init(from decoder: Decoder) throws {
        state = .decoded(try decoder.singleValueContainer().decode(Converter.ErasedCodable.self))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(state.value)
    }
}
