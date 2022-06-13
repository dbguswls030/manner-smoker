//
//  HomeEntity.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/14.
//

import Foundation

// MARK: - Welcome
struct HomeEntity: Codable {
    var httpStatus: String
    var message: JSONNullHome?
    var response: [HomeResponse]
}

// MARK: - Response
struct HomeResponse: Codable {
    var userId, year, month, day: Int
    var createdDate: String

    enum CodingKeys: String, CodingKey {
        case userId
        case year, month, day, createdDate
    }
}

// MARK: - Encode/decode helpers

class JSONNullHome: Codable, Hashable {

    public static func == (lhs: JSONNullHome, rhs: JSONNullHome) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullHome.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
