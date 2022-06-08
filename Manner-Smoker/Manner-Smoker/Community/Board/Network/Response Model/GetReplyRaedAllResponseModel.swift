//
//  GetReplyResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
struct GetReplyRaedAllResponseModel: Decodable{
    let response: [GetReplyReadAllResponseModelResponses]
    
    enum CodingKeys: String, CodingKey{
        case response
    }
}

struct GetReplyReadAllResponseModelResponses: Decodable{
    let createdDate: String
    let modifiedDate: String
    let postId: Int
    let replyContent: String
    let replyId: Int
    let userId: Int
    
    enum CodingKeys: String, CodingKey{
        case createdDate, modifiedDate, postId, replyContent, replyId, userId
    }
}

//{
//  "httpStatus": "ACCEPTED",
//  "message": "string",
//  "response": [
//    {
//      "createdDate": "2022-06-08T01:22:05.204Z",
//      "modifiedDate": "2022-06-08T01:22:05.204Z",
//      "postId": 0,
//      "replyContent": "string",
//      "replyId": 0,
//      "userId": 0
//    }
//  ]
//}
