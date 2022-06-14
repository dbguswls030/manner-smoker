//
//  GetPostReadAllResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct GetPostReadAllResponseModel: Codable {
    var httpStatus: String
    var message: JSONNullPostRead?
    var response: [GetPostReadAllResponseModelResponses]
}

// MARK: - Response
struct GetPostReadAllResponseModelResponses: Codable {
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

class JSONNullPostRead: Codable, Hashable {

    public static func == (lhs: JSONNullPostRead, rhs: JSONNullPostRead) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}






