//
//  DeletePostRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//

import Foundation
import Alamofire
struct DeletePostRequestModel{
    var postId: Int
    
    init(postId: Int){
        self.postId = postId
        headers["Authorization"] = Constants.ACESS_TOKEN
    }
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]
}
