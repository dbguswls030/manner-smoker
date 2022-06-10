    //
    //  SmokeAmountDataManager.swift
    //  Manner-Smoker
    //
    //  Created by RooZin on 2022/06/09.
    //

    import Foundation
    import Alamofire

    struct SmokeAmountDataManager {
        
        func addSmokeAmount()  {
            let param : Parameters = [ "userId" : Constants.SERVER_USER_ID]
            
            // 토큰 헤더 추가
            Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
            print(Constants.headerJSON)
            AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount", method: .post, parameters: param, encoding : JSONEncoding.default, headers: Constants.headerJSON)
                .validate()
                .responseDecodable(of: SmokeAmountEntity.self) { response in
                    switch response.result {
                    case .success(let response):
                        print(response)
                        print("연동성공")
                    case .failure(let error):
                        print("연동실패")
                        print(error.localizedDescription)
                    }
                }
    
        }
    }

