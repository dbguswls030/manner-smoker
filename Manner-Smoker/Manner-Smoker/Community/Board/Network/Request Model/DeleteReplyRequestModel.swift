//
//  DeleteReplyRequestModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/10.
//

import Foundation
import Alamofire
struct DeleteReplyRequestModel{
    var replyId: Int
    
    init(replyId: Int){
        self.replyId = replyId
        headers["Authorization"] = Constants.ACESS_TOKEN
    }
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]
}
