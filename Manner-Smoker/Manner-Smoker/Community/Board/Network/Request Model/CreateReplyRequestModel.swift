//
//  CreateReplyRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/09.
//

import Foundation
import Alamofire
struct CreateReplyRequestModel{
    let postId: Int
    let replyContent: String
    let userId: Int
    
    init(postId: Int, replyContent: String, userId: Int){
        self.postId = postId
        self.replyContent = replyContent
        self.userId = userId
        headers["Authorization"] = Constants.ACESS_TOKEN
        parameters["postId"] = postId
        parameters["replyContent"] = replyContent
        parameters["userId"] = userId
    }
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]
}


//{
//  "postId": 0,
//  "replyContent": "string",
//  "userId": 0
//}
