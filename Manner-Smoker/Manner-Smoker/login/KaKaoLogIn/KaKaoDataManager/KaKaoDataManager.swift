//
//  KaKaoDataManager.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/07.
//

import Foundation
import Alamofire

struct KaKaoDataManager {
    //MARK: - 토큰 정보 넘기기
    
    func transferToken() {
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/login/\(Constants.MY_TOKEN)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: KakaoEntity.self) { response in
                switch response.result {
                case .success(let result):
                    Constants.ACESS_TOKEN = (result.response?.accessToken)!
                    
                    print("요청성공!!!!!!!")
                case .failure(let error):
                    print("요청실패!!!!!!!")
                    print(error.localizedDescription)
                }
            }
    }
}


