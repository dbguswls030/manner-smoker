//
//  BoardViewModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
class BoardViewModel{
    var postResponse: GetPostReadOneResponseModelResponses?
    var replyResponse = [GetReplyReadAllResponseModelResponses]()
    var postId: Int?
    
    func getReley(completion: @escaping (()->())){
        resetReplyData()
        guard let postId = postId else {
            return
        }

        CommunityManager.shared.getReplyReadAll(model: GetReplyReadAllRequestModel(postId: "\(postId)")) { result in
            self.replyResponse = result.response
            completion()
        }
    }
    func getPost(completion: @escaping (()->())){
        resetPostData()
        guard let postId = postId else {
            return
        }
        CommunityManager.shared.getPostReadOne(model: GetPostReadOneRequestModel(postId: "\(postId)")) { result in
            self.postResponse = result.response
            completion()
        }
    }
    func getPostId()->Int{
        guard let postId = postId else {
            return -1
        }
        return postId
    }
    
    func numOfCount() -> Int{
        return self.replyResponse.count
    }
    
    func resetReplyData(){
        self.replyResponse.removeAll()
    }
    func resetPostData(){
        self.postResponse = nil
    }
}
