# TypeErasedCodable

A property wrapper that allows non Codable types to be represented by an underlying Codable type.

# Motivation

When migrating an older codebase from Objective-C to Swift, it's common to have Objective-C types like NSNumber used to represent optional numbers in parsed JSON. Unfortunately, if you want to convert these types to Codable and still have Objective-C call sites, then you will run into many interoperability errors.

Imagine the following Objective-C class:

```objective-c
@interface Person : NSObject
@property (readwrite, nullable) NSNumber *age;
@end
```

When converting it to Swift it would ideally look like:

```swift
@objc class Person: NSObject, Codable {
    @objc let age: Int?
}
```

But the optional integer does not bridge to Objective-C

> Property cannot be marked @objc because its type cannot be represented in Objective-C

## Usage

To fix the above example, change the implementation to use TypeErasedCodable:

```swift
@objc class Person: NSObject, Codable {
    @TypeErasedCodable<NSNumberToIntConverter> @objc var age: NSNumber?
}
```

You can make your own converters, and the usages go beyond Objective-C briding. Here we convert a non present Boolean to false to avoid having to deal with optionals:

 ```swift
struct Person: Codable {
    @TypeErasedCodable<NSNumberToIntConverter> var isAdult: Bool
}
```

## Installation

Add the following to your project's `Package.swift` file:

```swift
.package(url: "https://github.com/jackgmarch/TypeErasedCodable", from: "0.0.1")
```

or add this package via the Xcode UI by going to File > Swift Packages > Add Package Dependency.

## License

```
MIT License

Copyright (c) 2022 Jack March

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
