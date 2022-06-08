//
//  CommunityViewModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
class CommunityViewModel{
    var response = [GetPostReadAllResponseModelResponses]()
    
    
    func getResponses(completion: @escaping (()->())){
        resetData()
        CommunityManager.shared.getPostReadAll(model: GetPostReadAllRequestModel()) { result in
            self.response = result.response
            completion()
        }
    }
    
    func resetData(){
        response.removeAll()
    }
    
    
    func getNumOfCount()->Int{
        return response.count
    }
    
    
}
