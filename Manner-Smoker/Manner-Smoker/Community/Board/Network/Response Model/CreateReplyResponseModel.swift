//
//  CreateReplyResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/09.
//

import Foundation

struct CreateReplyResponseModel: Decodable{
    let response: [CreateReplyResponseModelResponses]
    
    enum CodingKeys: String, CodingKey{
        case response
    }
}

struct CreateReplyResponseModelResponses: Decodable{
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
//  "response": {
//    "createdDate": "2022-06-09T13:44:22.103Z",
//    "modifiedDate": "2022-06-09T13:44:22.103Z",
//    "postId": 0,
//    "replyContent": "string",
//    "replyId": 0,
//    "userId": 0
//  }
//}
