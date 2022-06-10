//
//  GetPostReadOneResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//

import Foundation
struct GetPostReadOneResponseModel:Decodable{
    let response: GetPostReadOneResponseModelResponses
    enum CodingKeys: String, CodingKey{
        case response
    }
}



struct GetPostReadOneResponseModelResponses: Decodable{
    let postId: Int
    let title: String
    let content: String
    let userId: Int
    let createdDate: String
    let modifiedDate: String
    
    enum CodingKeys: String, CodingKey{
        case postId, title, content, userId, createdDate, modifiedDate
    }
}
//{
//    "httpStatus": "OK",
//    "message": null,
//    "response": [
//        {
//            "postId": 1,
//            "title": "test",
//            "content": "test",
//            "userId": 3,
//            "createdDate": "2022-06-05T23:04:10",
//            "modifiedDate": "2022-06-05T23:04:10"
//        }
//    ]
//}
//{
//  "httpStatus": "ACCEPTED",
//  "message": "string",
//  "response": {
//    "content": "string",
//    "createdDate": "2022-06-09T23:04:01.941Z",
//    "modifiedDate": "2022-06-09T23:04:01.941Z",
//    "postId": 0,
//    "title": "string",
//    "userId": 0
//  }
//}
