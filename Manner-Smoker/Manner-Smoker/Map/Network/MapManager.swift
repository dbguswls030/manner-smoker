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
    
    let GetAllSmokeAreaURL = "\(Constants.BackEndAPI.BASE_URL)/area/all"
    
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
extension MapManager{
    func requestSmokeArea(model: GetAllSmokeAreaRequestModel){
        AF.request(GetAllSmokeAreaURL, method: .get, parameters: model.parameters, encoding: URLEncoding.default, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: init MapList Requesting...")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let decodeData = try JSONDecoder().decode(GetAllSmokeAreaResponseModel.self, from: response.data!)
                    self.convertSmokeAreaResponseModel(model: decodeData)
                    
                }catch{
                    print("Error : Error: init MapList JsonDecoding ...")
                }
            default:
                print("Error: init MapList status code value is not 200")
            }
        }
    }
    func convertSmokeAreaResponseModel(model: GetAllSmokeAreaResponseModel){
        for item in model.response{
            let map = Map(area: item.area, latitude: Double(item.latitude)!, longitude: Double(item.longitude)!)
            self.mapList.append(map)
        }
    }
}
