//
//  BoardViewModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
class BoardViewModel{
    var response = [GetReplyReadAllResponseModelResponses]()
    var postId: Int?
    
    func searchComment(){
        guard let postId = postId else {
            return
        }
        CommunityManager.shared.getReplyReadAll(model: GetReplyReadAllRequestModel(query: "\(postId)")) { result in
            self.response = result.response
        }
        
        
    }
    
    func numOfCount() -> Int{
        return self.response.count
    }
    
    func resetData(){
        response.removeAll()
    }
}
