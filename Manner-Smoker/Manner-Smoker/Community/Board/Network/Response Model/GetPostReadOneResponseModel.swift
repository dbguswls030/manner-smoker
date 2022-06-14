//
//  GetPostReadOneResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct GetPostReadOneResponseModel: Codable {
    var httpStatus: String
    var message: JSONNullPostReadOne?
    var response: GetPostReadOneResponseModelResponses
}

// MARK: - Response
struct GetPostReadOneResponseModelResponses: Codable {
    var postId: Int
    var content: String
    var userId: Int
    var nickname: String
    var thumbnailURL: String
    var createdDate, modifiedDate: String

    enum CodingKeys: String, CodingKey {
        case postId
        case content
        case userId
        case nickname, thumbnailURL, createdDate, modifiedDate
    }
}

// MARK: - Encode/decode helpers

class JSONNullPostReadOne: Codable, Hashable {

    public static func == (lhs: JSONNullPostReadOne, rhs: JSONNullPostReadOne) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullPostReadOne.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
