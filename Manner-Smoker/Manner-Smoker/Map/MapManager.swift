//
//  MapManager.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/04/03.
//

import Foundation
import Alamofire
class MapManager{
    static let shared = MapManager()
    var mapList = [Map]()
    
    
    let SearchLocationWithKeywordURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    
    
    func requestLocationWithAddress(model: SearchLoactionWithAddressRequestModel, completion: @escaping (SearchLoactionWithAddressResponseModel)-> ()){
        
        AF.request(SearchLocationWithKeywordURL, method: .get, parameters: model.parameters, encoding: URLEncoding.default, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error : didEditingThenMoveMap statusCode error")
                return
            }
            
            
            switch statusCode{
            case 200:
                do{
                    let decodeData = try JSONDecoder().decode(SearchLoactionWithAddressResponseModel.self, from: response.data!)
                    completion(decodeData)
                }catch{
                    print("Error : didEditingThenMoveMap JsonDecoding error")
                }
            default:
                print("Error : didEditingThenMoveMap status code value is not 200")
                return
            }
        }
    }
    
    
    
    
}
