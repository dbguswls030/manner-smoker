//
//  GetPostReadOne.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//

import Foundation
import Alamofire
struct GetPostReadOneRequestModel{
    let postId: String
    init(postId: String){
        self.postId = postId
    }
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]
}
