//
//  CodableExtension.swift
//  TutorFoundation
//
//  Created by yaoyuan on 2021/7/22.
//

import Foundation

public protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    public init(wrappedValue initialValue: T.Value) {
      self.wrappedValue = initialValue
    }
}

extension Default: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }

    public typealias True = Default<Bool.True>
    public typealias False = Default<Bool.False>
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

// MARK: - Type DefaultValue Extension

public extension Bool {
    enum False: DefaultValue {
        public static let defaultValue = false
    }

    enum True: DefaultValue {
        public static let defaultValue = true
    }
}

extension String: DefaultValue {
    public static let defaultValue = ""
}

extension Int: DefaultValue {
    public static let defaultValue = 0
}
