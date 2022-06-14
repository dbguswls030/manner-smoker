//
//  GetReplyResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct GetReplyRaedAllResponseModel: Codable {
    var httpStatus: String
    var message: JSONNullReplyAll?
    var response: [GetReplyReadAllResponseModelResponses]
}

// MARK: - Response
struct GetReplyReadAllResponseModelResponses: Codable {
    var replyId: Int
    var replyContent: String
    var postId, userId: Int
    var nickname: String
    var thumbnailURL: String
    var createdDate, modifiedDate: String

    enum CodingKeys: String, CodingKey {
        case replyId
        case replyContent
        case postId
        case userId
        case nickname, thumbnailURL, createdDate, modifiedDate
    }
}

// MARK: - Encode/decode helpers

class JSONNullReplyAll: Codable, Hashable {

    public static func == (lhs: JSONNullReplyAll, rhs: JSONNullReplyAll) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullReplyAll.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



