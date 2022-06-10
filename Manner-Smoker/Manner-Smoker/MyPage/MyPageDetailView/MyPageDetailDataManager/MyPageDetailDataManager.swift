//
//  MyPageDetailDataManager.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/10.
//

import Foundation
import Alamofire

struct MyPageDetailDataManager {
    
    func getDaySmokeResult(_ year : Int, _ month : Int, _ day : Int, viewController : MyPageDetailVC) {
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/\(Constants.SERVER_USER_ID)?year=\(year)&month=\(month)&day=\(day)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: DaySmokeEntity.self) { response in
                print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                print(response)
                switch response.result {
                case .success(let result):
                    
                    viewController.dayValueR = result.response
                    
                    print("왜 안되는데&&&&&&&&&&&&&&&&&&&&&&&&&")
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
    }
    
    func getMonthSmokeResult(_ year : Int, _ month : Int, viewController : MyPageDetailVC) {
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/month/\(Constants.SERVER_USER_ID)?year=\(year)&month=\(month)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: MonthSmokeEntity.self) { response in
                print(response)
                switch response.result {
                case .success(let result):
                    
                    viewController.monthValueR = result.response
                    
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
    }
    
    func getYearSmokeResult(_ year : Int, viewController : MyPageDetailVC) {
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/year/\(Constants.SERVER_USER_ID)?year=\(year)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: YearSmokeEntity.self) { response in
                print(response)
                switch response.result {
                case .success(let result):
                    
                    viewController.yearValueR = result.response
                    
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
    }
}
