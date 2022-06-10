//
//  UpdatePostRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//

import Foundation
import Alamofire
struct UpdatePostRequestModel{
    let postId: Int
    init(postId: Int,content: String, title: String){
        self.postId = postId
        headers["Authorization"] = Constants.ACESS_TOKEN
        parameters["content"] = content
        parameters["title"] = title
    }
    
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]
}

//{
//  "content": "string",
//  "title": "string"
//}
