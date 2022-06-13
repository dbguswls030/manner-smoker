//
//  HomeDataManager.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/14.
//

import Foundation
import Alamofire

struct HomeDataManager {
    
    func getDaySmokeAmountHome(_ year : Int, _ month : Int, _ day : Int, viewController : HeaderHomeVC)  {
        var amount : Int = 0
        
        Constants.headerJSON["Authorization"] = Constants.ACESS_TOKEN
        AF.request(Constants.BackEndAPI.BASE_URL + "/api/smoke-amount/\(Constants.SERVER_USER_ID)?year=\(year)&month=\(month)&day=\(day)", method: .get, parameters: nil, headers: Constants.headerJSON)
            .validate()
            .responseDecodable(of: DaySmokeEntity.self) { response in
                print(response)
                switch response.result {
                case .success(let result):
                    amount = result.response.count
                    print("@@@@@@@@@@@@@@@@@@@@@@check")
                    DispatchQueue.main.async {
                        let percentage = (amount / Constants.STANDARD_SMOKE_AMOUNT) * 100
                        
                        print("%%%%%%%%%%%%%%%%%")
                        print(amount)
                        print(Constants.STANDARD_SMOKE_AMOUNT)
                        print(percentage)
                        switch percentage {
                        case 0...33 :
                            viewController.mainView.backgroundColor = .systemBlue
                            viewController.statusImg.image = UIImage(named: "face-1")
                            viewController.stausLbl.text = "매우 좋음"
                        case 34...66 :
                            viewController.mainView.backgroundColor = .systemIndigo
                            viewController.statusImg.image = UIImage(named: "face-2")
                            viewController.stausLbl.text = "좋음"
                        case 67...100 :
                            viewController.mainView.backgroundColor = .systemYellow
                            viewController.statusImg.image = UIImage(named: "face-3")
                            viewController.stausLbl.text = "보통"
                        case 101...120 :
                            viewController.mainView.backgroundColor = .systemOrange
                            viewController.statusImg.image = UIImage(named: "face-4")
                            viewController.stausLbl.text = "나쁨"
                        case 121... :
                            viewController.mainView.backgroundColor = .systemRed
                            viewController.statusImg.image = UIImage(named: "face-5")
                            viewController.stausLbl.text = "매우 나쁨"
                        default :
                            print("Error")
                        }
                        print(amount)
                    }
                case .failure(let error):
                    print("연동실패")
                    print(error.localizedDescription)
                }
            }
    }
}
