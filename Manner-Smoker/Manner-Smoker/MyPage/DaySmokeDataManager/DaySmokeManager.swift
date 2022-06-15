//
//  DaySmokeManager.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/09.
//

import Foundation
import Alamofire

struct DaySmokeDataManager {
    
    func getDaySmokeAmount(_ year : Int, _ month : Int, _ day : Int, viewController : HeaderMyPageVC)  {
        var amount : Int = 0
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/\(Constants.SERVER_USER_ID)?year=\(year)&month=\(month)&day=\(day)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: DaySmokeEntity.self) { response in
                print(response)
                switch response.result {
                case .success(let result):
                    amount = result.response.count
                    print("@@@@@@@@@@@@@@@@@@@@@@")
                    DispatchQueue.main.async {
                        viewController.selectedDaySmokeAmountLbl.text = "\(amount)/\(Constants.STANDARD_SMOKE_AMOUNT)"
                    }
                    print(amount)
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
        
    }
    
    func getDaySmokeInfo(_ year : Int, _ month : Int, _ day : Int, viewController : HeaderMyPageVC) {
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/\(Constants.SERVER_USER_ID)?year=\(year)&month=\(month)&day=\(day)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: DaySmokeEntity.self) { response in
                print(response)
                switch response.result {
                case .success(let result):
                    viewController.smokeInfo = result.response
                    viewController.myPageTableView.reloadData()
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
    }
}
