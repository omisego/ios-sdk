//
//  SearchParams.swift
//  OmiseGO
//
//  Created by Mederic Petit on 17/9/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import BigInt

public protocol Filterable {
    associatedtype FilterableFields: RawEnumerable where FilterableFields.RawValue == String
}

enum BooleanFilterComparator: String, Encodable {
    case equal = "eq"
    case notEqual = "neq"
}

enum StringFilterComparator: String, Encodable {
    case equal = "eq"
    case contains
    case startsWith = "starts_with"
}

enum NumericFilterComparator: String, Encodable {
    case equal = "eq"
    case notEqual = "neq"
    case lessThan = "lt"
    case lessThanOrEqual = "lte"
    case greaterThan = "gt"
    case greaterThanOrEqual = "gte"
}

public struct Filter<F: Filterable>: APIParameters {
    var field: String
    var comparator: String
    var value: Any

    enum CodingKeys: String, CodingKey {
        case field
        case comparator
        case value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(field, forKey: .field)
        try container.encode(comparator, forKey: .comparator)
        switch self.value {
        case let value as String: try container.encode(value, forKey: .value)
        case let value as Bool: try container.encode(value, forKey: .value)
        case let value as BigInt: try container.encode(value, forKey: .value)
        default:
            throw OMGError.unexpected(message: "Unexepected value type for filter")
        }
    }
}

extension Filterable {
    static func filter(field: FilterableFields, comparator: StringFilterComparator, value: String) -> Filter<Self> {
        return Filter(field: field.rawValue, comparator: comparator.rawValue, value: value)
    }

    static func filter(field: FilterableFields, comparator: BooleanFilterComparator, value: Bool) -> Filter<Self> {
        return Filter(field: field.rawValue, comparator: comparator.rawValue, value: value)
    }

    static func filter(field: FilterableFields, comparator: NumericFilterComparator, value: BigInt) -> Filter<Self> {
        return Filter(field: field.rawValue, comparator: comparator.rawValue, value: value)
    }

    static func filter(field: String, comparator: StringFilterComparator, value: String) -> Filter<Self> {
        return Filter(field: field, comparator: comparator.rawValue, value: value)
    }

    static func filter(field: String, comparator: BooleanFilterComparator, value: Bool) -> Filter<Self> {
        return Filter(field: field, comparator: comparator.rawValue, value: value)
    }

    static func filter(field: String, comparator: NumericFilterComparator, value: BigInt) -> Filter<Self> {
        return Filter(field: field, comparator: comparator.rawValue, value: value)
    }
}

public struct FilterParams<F: Filterable>: APIParameters {
    let matchAll: [Filter<F>]?
    let matchAny: [Filter<F>]?

    public init(matchAll: [Filter<F>]? = nil, matchAny: [Filter<F>]? = nil) {
        self.matchAll = matchAll
        self.matchAny = matchAny
    }

    enum CodingKeys: String, CodingKey {
        case matchAll = "match_all"
        case matchAny = "match_any"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(matchAll, forKey: .matchAll)
        try container.encodeIfPresent(matchAny, forKey: .matchAny)
    }
}
