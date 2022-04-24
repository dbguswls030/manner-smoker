//
//  SearchLoactionWithAddress.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/04/03.
//

import Foundation
import Alamofire
struct SearchLoactionWithAddressRequestModel{
    let query: String
    
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [ "Authorization": "KakaoAK \(Constants.KaKaoAPI.REST_API_KEY)"]
    
    init(query: String){
        self.query = query
        parameters["query"] = self.query
    }
    
}
