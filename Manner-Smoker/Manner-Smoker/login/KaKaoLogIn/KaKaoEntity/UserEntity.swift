//
//  UserEntity.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/09.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct UserEntity: Codable {
    var httpStatus: String
    var message: JSONNullUser?
    var response: UserResponse
}

// MARK: - Response
struct UserResponse: Codable {
    var id: Int
    var email, username: String
}

// MARK: - Encode/decode helpers

class JSONNullUser: Codable, Hashable {

    public static func == (lhs: JSONNullUser, rhs: JSONNullUser) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullUser.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
