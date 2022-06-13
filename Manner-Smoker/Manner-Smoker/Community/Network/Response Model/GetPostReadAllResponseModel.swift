//
//  GetPostReadAllResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
struct GetPostReadAllResponseModel: Decodable{
    let response: [GetPostReadAllResponseModelResponses]
    enum CodingKeys: String, CodingKey{
        case response
    }
}
struct GetPostReadAllResponseModelResponses: Decodable{
    let postId: Int
    let content: String
    let userId: Int
    let createdDate: String
    let modifiedDate: String
    let nickname: JSONNull?
    let thumbnailURL: JSONNull?
    enum CodingKeys: String, CodingKey{
        case postId, content, userId, createdDate, modifiedDate, thumbnailURL, nickname
    }
}
//  "httpStatus": "ACCEPTED",
//  "message": "string",
//  "response": [
//    {
//      "content": "string",
//      "createdDate": "2022-06-13T17:28:37.979Z",
//      "modifiedDate": "2022-06-13T17:28:37.979Z",
//      "nickname": "string",
//      "postId": 0,
//      "thumbnailURL": "string",
//      "userId": 0
//    }
//  ]
//}
