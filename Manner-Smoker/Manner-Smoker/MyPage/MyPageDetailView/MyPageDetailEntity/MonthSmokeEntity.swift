//
//  MonthSmokeEntity.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/10.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MonthSmokeEntity: Codable {
    var httpStatus: String
    var message: JSONNullMonth?
    var response: [MonthResponse]
}

// MARK: - Response
struct MonthResponse: Codable {
    var userId, year, month, day: Int
    var createdDate: String

    enum CodingKeys: String, CodingKey {
        case userId
        case year, month, day, createdDate
    }
}

// MARK: - Encode/decode helpers

class JSONNullMonth: Codable, Hashable {

    public static func == (lhs: JSONNullMonth, rhs: JSONNullMonth) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullMonth.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
