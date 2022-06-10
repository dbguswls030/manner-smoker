//
//  YearSmokeEntity.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/10.
//

import Foundation

// MARK: - Welcome
struct YearSmokeEntity: Codable {
    var httpStatus: String
    var message: JSONNullYear?
    var response: [YearResponse]
}

// MARK: - Response
struct YearResponse: Codable {
    var userId, year, month, day: Int
    var createdDate: String

    enum CodingKeys: String, CodingKey {
        case userId
        case year, month, day, createdDate
    }
}

// MARK: - Encode/decode helpers

class JSONNullYear: Codable, Hashable {

    public static func == (lhs: JSONNullYear, rhs: JSONNullYear) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullYear.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
