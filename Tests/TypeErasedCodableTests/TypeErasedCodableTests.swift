import XCTest
@testable import TypeErasedCodable

// TODO: Improve test coverage

final class TypeErasedCodableTests: XCTestCase {
    func testNSNumberToIntConvertible() throws {
        
        struct Body: Codable {
            @TypeErasedCodable<NSNumberToIntConvertible> var number: NSNumber?
        }
        
        let json = " { \"number\": 5 }"
        let data = json.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(Body.self, from: data)
        
        XCTAssertEqual(decoded.number!.intValue, 5)
        
        let encoded = try JSONEncoder().encode(decoded)
        let reDecoded = try JSONDecoder().decode(Body.self, from: encoded)
        
        XCTAssertEqual(reDecoded.number!.intValue, decoded.number!.intValue)
    }
    
    func testNonPresentBoolToFalse() throws {
        
        struct Body: Codable {
            @TypeErasedCodable<NonPresentBoolToFalse> var bool: Bool
        }
        
        let json = " { \"invalidJson\": 5 }"
        let data = json.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(Body.self, from: data)
        
        XCTAssertEqual(decoded.bool, false)
        
        let encoded = try JSONEncoder().encode(decoded)
        let reDecoded = try JSONDecoder().decode(Body.self, from: encoded)
        
        XCTAssertEqual(reDecoded.bool, decoded.bool)
    }
    
    func testSettingCustomValueOverridesForEncoding() throws {
        
        struct Body: Codable {
            @TypeErasedCodable<NSNumberToIntConvertible> var number: NSNumber?
        }
        
        let json = " { \"number\": 5 }"
        let data = json.data(using: .utf8)!
        var decoded = try JSONDecoder().decode(Body.self, from: data)
        
        XCTAssertEqual(decoded.number!.intValue, 5)
        
        decoded.number = 6
        
        let encoded = try JSONEncoder().encode(decoded)
        let reDecoded = try JSONDecoder().decode(Body.self, from: encoded)
        
        XCTAssertEqual(6, reDecoded.number)
    }
}
