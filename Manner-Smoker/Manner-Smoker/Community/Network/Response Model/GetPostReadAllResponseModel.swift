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
