//
//  GetReplyRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
import Alamofire
struct GetReplyReadAllRequestModel{
    let postId: String
    var parameters : Parameters = [:]
    var headers : HTTPHeaders = [:]
    init(postId: String){
        self.postId = postId
    }
}
