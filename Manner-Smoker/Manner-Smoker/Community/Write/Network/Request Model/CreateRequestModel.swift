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
    let title: String
    let userId: Int
    init(content: String, title: String, userId: Int){
        self.content = content
        self.title = title
        self.userId = userId
        parameters["content"] = content
        parameters["title"] = title
        parameters["userId"] = userId
    }
    var parameters : Parameters = [ : ]
    var headers: HTTPHeaders = []
}
