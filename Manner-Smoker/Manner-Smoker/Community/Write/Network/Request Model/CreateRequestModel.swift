//
//  CreateRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
import Alamofire

struct CreateRequestModel{
    let content: String
    let userId: Int
    init(content: String, userId: Int){
        self.content = content
        self.userId = userId
        parameters["content"] = content
        parameters["userId"] = userId
        headers["Authorization"] = Constants.ACESS_TOKEN
    }
    var parameters : Parameters = [ : ]
    var headers: HTTPHeaders = []
}
